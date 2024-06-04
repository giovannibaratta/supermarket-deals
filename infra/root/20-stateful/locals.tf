locals {
  env = terraform.workspace
  suffix = "${local.env}-random_id.suffix.id"
}

resource "random_id" "suffix" {
  byte_length = 8
}