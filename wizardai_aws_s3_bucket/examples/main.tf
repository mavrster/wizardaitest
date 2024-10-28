# Basic example

module "s3_bucket" {
  source                          = "../"
  environment                     = "development"
  bucket_suffix                   = "test-bucket"
  enable_versioning               = true
  lifecycle_configuration_enabled = true

  default_tags = {
    project = "test_project"
  }
}
