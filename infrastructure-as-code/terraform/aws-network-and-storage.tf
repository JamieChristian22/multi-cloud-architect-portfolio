resource "aws_s3_bucket" "raw" {
  bucket = "novaretail-prod-datalake-raw"
}

resource "aws_s3_bucket" "curated" {
  bucket = "novaretail-prod-datalake-curated"
}

resource "aws_s3_bucket" "analytics" {
  bucket = "novaretail-prod-datalake-analytics"
}

resource "aws_kms_key" "data_lake" {
  description             = "KMS key for NovaRetail data lake buckets"
  deletion_window_in_days = 30
}

resource "aws_s3_bucket_server_side_encryption_configuration" "raw_sse" {
  bucket = aws_s3_bucket.raw.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.data_lake.arn
    }
  }
}
