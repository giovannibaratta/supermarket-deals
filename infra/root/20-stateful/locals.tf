locals {
  stage = "20-stateful"
  env = terraform.workspace
  suffix = "${local.env}-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  stage_tags = {
    stage = local.stage
    env = terraform.workspace
  }

  provider_tags = merge(var.tags, local.stage_tags)
}