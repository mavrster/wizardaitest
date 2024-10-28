provider "aws" {
  default_tags {
    tags = merge(
      var.default_tags,
      { "Environment" = var.environment }
    )
  }
}
