output "firehose_stream_arn" {
  description = "ARN do Firehose Stream"
  value       = length(aws_kinesis_firehose_delivery_stream.newrelic_firehose_stream) > 0 ? aws_kinesis_firehose_delivery_stream.newrelic_firehose_stream[0].arn : ""
}
