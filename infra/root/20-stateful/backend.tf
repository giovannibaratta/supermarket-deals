terraform {
  backend "s3" {
    bucket = "terraform-state-file-29b3f79b30cd369f"
    region = "us-east-1"
    key = "terraform.tfstate"
    workspace_key_prefix = "20-stateful"
  }
}

module "zerozero_bootstrap_output" {
  source  = "giovannibaratta/tf-output-read/aws"
  version = "0.0.1"

  source_object= {
    bucket_id = var.state_bucket_id
    object_path = "output/00-bootstrap/non-sensitive.json"
  }
}