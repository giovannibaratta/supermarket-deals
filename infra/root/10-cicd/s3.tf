resource "aws_s3_bucket" "code_build_logs" {
  bucket = "code-build-${local.suffix}"
}
