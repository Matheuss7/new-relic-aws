terraform {
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

// Recurso para integração de conta AWS com o New Relic (PUSH)
resource "newrelic_cloud_aws_link_account" "newrelic_cloud_integration_push" {
  count = var.integration_exists ? 0 : 1

  account_id             = var.newrelic_account_id
  arn                    = var.iam_role_arn
  metric_collection_mode = "PUSH"
  name                   = "${var.name}"
  depends_on             = [var.iam_policy_attach]
}

// Recurso para criar a chave de acesso API do New Relic
resource "newrelic_api_access_key" "newrelic_aws_access_key" {
  count = var.integration_exists ? 0 : 1

  account_id  = var.newrelic_account_id
  key_type    = "INGEST"
  ingest_type = "LICENSE"
  name        = "Metric Stream Key for ${var.name}"
  notes       = "AWS Cloud Integrations Metric Stream Key"
}

// Recurso para integração de conta AWS com o New Relic (PULL)
resource "newrelic_cloud_aws_link_account" "newrelic_cloud_integration_pull" {
  count = var.integration_exists ? 0 : 1

  account_id             = var.newrelic_account_id
  arn                    = var.iam_role_arn
  metric_collection_mode = "PULL"
  name                   = "${var.name} pull"
  depends_on             = [var.iam_policy_attach]
}

// Recurso para integrar serviços da AWS com o New Relic
resource "newrelic_cloud_aws_integrations" "newrelic_cloud_integration_pull" {
  count = var.integration_exists ? 0 : 1

  account_id        = var.newrelic_account_id
  linked_account_id = length(newrelic_cloud_aws_link_account.newrelic_cloud_integration_pull) > 0 ? newrelic_cloud_aws_link_account.newrelic_cloud_integration_pull[0].id : ""

  // Configurações dos serviços da AWS a serem integrados
  billing {}
  cloudtrail {}
  health {}
  trusted_advisor {}
  vpc {}
  x_ray {}
  s3 {}
  doc_db {}
  sqs {}
  ebs {}
  alb {}
  elasticache {}
  api_gateway {}
  auto_scaling {}
  aws_app_sync {}
  aws_athena {}
  aws_cognito {}
  aws_connect {}
  aws_direct_connect {}
  aws_fsx {}
  aws_glue {}
  aws_kinesis_analytics {}
  aws_media_convert {}
  aws_media_package_vod {}
  aws_mq {}
  aws_msk {}
  aws_neptune {}
  aws_qldb {}
  aws_route53resolver {}
  aws_states {}
  aws_transit_gateway {}
  aws_waf {}
  aws_wafv2 {}
  cloudfront {}
  dynamodb {}
  ec2 {}
  ecs {}
  efs {}
  elasticbeanstalk {}
  elasticsearch {}
  elb {}
  emr {}
  iam {}
  iot {}
  kinesis {}
  kinesis_firehose {}
  lambda {}
  rds {}
  redshift {}
  route53 {}
  ses {}
  sns {}
}

// Bucket S3 para o Configuration Recorder
resource "aws_s3_bucket" "newrelic_configuration_recorder_s3" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

// Role IAM para o Configuration Recorder
resource "aws_iam_role" "newrelic_configuration_recorder" {
  name               = "newrelic_configuration_recorder-${var.name}"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "config.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
      ]
    }
EOF
}

// Política de permissões para o Configuration Recorder
resource "aws_iam_role_policy" "newrelic_configuration_recorder_s3" {
  name = "newrelic-configuration-recorder-s3-${var.name}"
  role = aws_iam_role.newrelic_configuration_recorder.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.newrelic_configuration_recorder_s3.arn}",
        "${aws_s3_bucket.newrelic_configuration_recorder_s3.arn}/*"
      ]
    }
  ]
}
POLICY
}

// Anexo da política ao role IAM do Configuration Recorder
resource "aws_iam_role_policy_attachment" "newrelic_configuration_recorder" {
  role       = aws_iam_role.newrelic_configuration_recorder.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

// Configuration Recorder do AWS Config
resource "aws_config_configuration_recorder" "newrelic_recorder" {
  name     = "newrelic_configuration_recorder-${var.name}"
  role_arn = aws_iam_role.newrelic_configuration_recorder.arn
}

// Status do Configuration Recorder
resource "aws_config_configuration_recorder_status" "newrelic_recorder_status" {
  name       = aws_config_configuration_recorder.newrelic_recorder.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.newrelic_recorder_delivery]
}

// Delivery Channel para o Configuration Recorder
resource "aws_config_delivery_channel" "newrelic_recorder_delivery" {
  name           = "newrelic_configuration_recorder-${var.name}"
  s3_bucket_name = aws_s3_bucket.newrelic_configuration_recorder_s3.bucket
  depends_on     = [
    aws_config_configuration_recorder.newrelic_recorder
  ]
}
