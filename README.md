# New Relic AWS Integration with Terraform

Este repositório contém a configuração do Terraform para integrar serviços da AWS com o New Relic. A infraestrutura é organizada em módulos para facilitar o gerenciamento e a manutenção.

## Estrutura do Projeto

```
Terraform/
├── newrelic-infra/
│   ├── inventories/
│   │   └── terraform.tfvars
│   ├── modules/
│   │   ├── cloudwatch/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── firehose/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── iam_roles/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── newrelic/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── s3_buckets/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── variables.tf

```


## Pré-requisitos

- Terraform instalado na sua máquina: [Instalação do Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
- Conta AWS com credenciais configuradas
- Conta New Relic com chave API

## Configuração

1. Clone este repositório:

   ```sh
   git@github.com:Matheuss7/new-relic-aws.git
     

2. Crie e configure o arquivo terraform.tfvars no diretório inventories com os valores das variáveis:

```yaml
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


```
Inicialização e Aplicação

Inicialize o Terraform:

```sh
terraform init
```

Visualize o plano de execução:

```hcl
terraform plan
```

Aplique o plano para provisionar os recursos:

```hcl
terraform apply -var-file=inventories/terraform.tfvars
```

Estrutura dos Módulos
IAM Roles
Define e cria os papéis IAM necessários para a integração do New Relic com a AWS.

Firehose
Configura o Kinesis Firehose para entregar dados para o New Relic.

S3 Buckets
Cria buckets S3 para backup do Firehose.

CloudWatch
Configura o CloudWatch Metric Stream para enviar métricas para o New Relic.

New Relic
Configura a integração da conta AWS com o New Relic, incluindo a criação de chaves de acesso API e a configuração de várias integrações de serviços AWS.

Limpeza
Para destruir os recursos provisionados, execute:

```hcl
terraform destroy -var-file=inventories/terraform.tfvars
