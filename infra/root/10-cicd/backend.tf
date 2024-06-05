terraform {
  backend "s3" {
    bucket = "terraform-state-file-29b3f79b30cd369f"
    region = "us-east-1"
    key = "terraform.tfstate"
    workspace_key_prefix = "10-cicd"
  }
}