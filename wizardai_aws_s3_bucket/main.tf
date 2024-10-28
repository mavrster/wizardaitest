/*
 * # Module: Creates encrypted s3 bucket.
 */

resource "aws_s3_bucket" "bucket" {
  bucket              = local.s3_bucket_name
  force_destroy       = var.force_destroy
  object_lock_enabled = var.enable_object_lock
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowSSLRequestsOnly",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.bucket.id}",
          "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
        ],
        "Condition": {
          "Bool": {
            "aws:SecureTransport": "false"
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count  = var.enable_versioning == true ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  count  = var.block_public_access == true ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = var.bucket_ownership
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "expiration" {
  count  = var.lifecycle_configuration_enabled == true ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  rule {
    id = "Expiration"
    expiration {
      days = var.lifecycle_configuration_expiration_days
    }
    status = var.lifecycle_configuration_status
  }
}
