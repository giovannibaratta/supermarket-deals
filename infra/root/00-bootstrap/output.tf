resource "local_file" "backend_config" {
  depends_on = [aws_s3_bucket.tf_state]

  filename = "backend.tf"

  content = templatefile("${path.module}/files/backend.tf.tpl", {
    bucket_id = aws_s3_bucket.tf_state.id,
    region = aws_s3_bucket.tf_state.region
  })
}

module "output" {
  depends_on = [aws_s3_bucket.tf_state]

  source  = "giovannibaratta/tf-output-write/aws"
  version = "0.0.5"

  data = {
    primary_region = var.primary_region
    tags = local.default_tags
  }

  destination = {
    bucket_id = aws_s3_bucket.tf_state.id,
    object_path = "output/00-bootstrap/non-sensitive.json"
  }
}