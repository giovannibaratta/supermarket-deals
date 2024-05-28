resource "local_file" "backend_config" {

  depends_on = [aws_s3_bucket.tf_state]

  filename = "backend.tf"

  content = templatefile("${path.module}/files/backend.tf.tpl", {
    bucket_id = aws_s3_bucket.tf_state.id,
    region = aws_s3_bucket.tf_state.region
  })
}