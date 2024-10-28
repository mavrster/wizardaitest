locals {
  s3_bucket_name = "wizardai-${lower(var.bucket_suffix)}-${lower(var.environment)}"
}
