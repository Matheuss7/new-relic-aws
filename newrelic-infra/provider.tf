terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    newrelic = {
      source  = "newrelic/newrelic"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "newrelic" {
  account_id = var.newrelic_account_id
  api_key    = var.newrelic_api_key
  region     = var.newrelic_region
}
