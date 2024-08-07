output "newrelic_metric_stream" {
  description = "Stream de métricas do CloudWatch"
  value       = aws_cloudwatch_metric_stream.newrelic_metric_stream.arn
}
