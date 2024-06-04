locals {
  default_tags = merge(var.tags, {
    managed-by = "terraform"
  })

  stage_tags = {
    stage = "00-bootstrap"
  }

  provider_tags = merge(local.default_tags, local.stage_tags)
}