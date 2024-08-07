terraform {
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

// Define a função para criar o role do Metric Stream para o Firehose
resource "aws_iam_role" "metric_stream_to_firehose" {
  name = "newrelic_metric_stream_to_firehose_role_${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "streams.metrics.cloudwatch.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

// Define a política para o role do Metric Stream para o Firehose
resource "aws_iam_role_policy" "metric_stream_to_firehose" {
  name = "default"
  role = aws_iam_role.metric_stream_to_firehose.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "firehose:PutRecord",
                "firehose:PutRecordBatch"
            ],
            "Resource": "${var.firehose_arn}"
        }
    ]
}
EOF
}

// Define o Metric Stream do CloudWatch para o Firehose
resource "aws_cloudwatch_metric_stream" "newrelic_metric_stream" {
  name          = "newrelic-metric-stream-${var.name}"
  role_arn      = aws_iam_role.metric_stream_to_firehose.arn
  firehose_arn  = var.firehose_arn
  output_format = "opentelemetry0.7"
}
