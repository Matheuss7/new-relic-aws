resource "aws_iam_role" "firehose_newrelic_role" {
  count = var.firehose_exists ? 0 : 1

  name = "firehose_newrelic_role_${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

// Recurso do Kinesis Firehose Delivery Stream
resource "aws_kinesis_firehose_delivery_stream" "newrelic_firehose_stream" {
  count = var.firehose_exists ? 0 : 1

  name        = "newrelic_firehose_stream_${var.name}"
  destination = "http_endpoint"

  http_endpoint_configuration {
    url                = var.newrelic_region == "US" ? "https://aws-api.newrelic.com/cloudwatch-metrics/v1" : "https://aws-api.eu01.nr-data.net/cloudwatch-metrics/v1"
    name               = "New Relic ${var.name}"
    access_key         = var.newrelic_access_key
    buffering_size     = 1
    buffering_interval = 60
    role_arn           = element(concat(aws_iam_role.firehose_newrelic_role.*.arn, tolist([""])), 0)
    s3_backup_mode     = "FailedDataOnly"

    s3_configuration {
      role_arn           = element(concat(aws_iam_role.firehose_newrelic_role.*.arn, tolist([""])), 0)
      bucket_arn         = var.s3_bucket_arn
      buffering_size     = 10
      buffering_interval = 400
      compression_format = "GZIP"
    }

    request_configuration {
      content_encoding = "GZIP"
    }
  }
}
