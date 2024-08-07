// Criação do bucket S3
resource "aws_s3_bucket" "newrelic_aws_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
  tags          = var.tags
}

// Configuração de controles de propriedade do bucket
resource "aws_s3_bucket_ownership_controls" "newrelic_ownership_controls" {
  bucket = aws_s3_bucket.newrelic_aws_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
