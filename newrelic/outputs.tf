output "newrelic_cloud_integration_push" {
  description = "ID da integração de push do New Relic"
  value       = length(newrelic_cloud_aws_link_account.newrelic_cloud_integration_push) > 0 ? newrelic_cloud_aws_link_account.newrelic_cloud_integration_push[0].id : ""
}

output "newrelic_cloud_integration_pull" {
  description = "ID da integração de pull do New Relic"
  value       = length(newrelic_cloud_aws_link_account.newrelic_cloud_integration_pull) > 0 ? newrelic_cloud_aws_link_account.newrelic_cloud_integration_pull[0].id : ""
}

output "newrelic_access_key" {
  description = "Chave de acesso API para o New Relic"
  value       = length(newrelic_api_access_key.newrelic_aws_access_key) > 0 ? newrelic_api_access_key.newrelic_aws_access_key[0].key : ""
  sensitive   = true
}
