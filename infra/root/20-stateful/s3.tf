resource "aws_s3_bucket" "flyer_staging" {
  bucket = "flyer-staging-${local.suffix}"
}
