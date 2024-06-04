provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "managed-by" = "terraform"
    }
  }
}