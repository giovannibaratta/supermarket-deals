provider "aws" {
  region = var.primary_region
  default_tags {
    tags = {
      "managed-by" = "terraform"
    }
  }
}