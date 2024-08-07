aws_region = "us-east-1" //Região que será implantado os recursos
newrelic_account_id = "" //ACCOUNT ID NEW RELIC
newrelic_api_key = "" //API KEY NEW RELIC
newrelic_region = "US" //Não mexer
name = "" //Nome do projeto ou conta que será monitorada
s3_bucket_name = "" //Nome do bucket
tags = {
  maintainer  = "matheus"
  created     = "terraform"
  application = "new-relic"
}
integration_exists = false // Alterar para true se a integração já existir, caso nao exista a integracao coloque false