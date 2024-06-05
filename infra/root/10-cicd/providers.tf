provider "aws" {
  region = var.primary_region

  default_tags {
    tags = local.provider_tags
  }
}