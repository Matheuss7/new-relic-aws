module "s3_buckets" {
  source         = "./modules/s3_buckets"
  s3_bucket_name = var.s3_bucket_name
  tags           = var.tags
}

module "firehose" {
  source              = "./modules/firehose"
  name                = var.name
  newrelic_region     = var.newrelic_region
  newrelic_access_key = module.newrelic.newrelic_access_key
  s3_bucket_arn       = module.s3_buckets.newrelic_aws_bucket_arn
}

module "cloudwatch" {
  source       = "./modules/cloudwatch"
  firehose_arn = module.firehose.firehose_stream_arn
  name         = var.name
}

module "iam_roles" {
  source              = "./modules/iam_roles"
  newrelic_account_id = var.newrelic_account_id
  name                = var.name
  tags                = var.tags
}

module "newrelic" {
  source              = "./modules/newrelic"
  newrelic_account_id = var.newrelic_account_id
  name                = var.name
  iam_role_arn        = module.iam_roles.newrelic_aws_role_arn
  iam_policy_attach   = module.iam_roles.newrelic_aws_policy_attach
  s3_bucket_name      = var.s3_bucket_name
  tags                = var.tags
  integration_exists  = var.integration_exists
}
