output "newrelic_aws_role_arn" {
  value = aws_iam_role.newrelic_aws_role.arn
}

output "newrelic_aws_policy_attach" {
  value = aws_iam_role_policy_attachment.newrelic_aws_policy_attach.id
}
