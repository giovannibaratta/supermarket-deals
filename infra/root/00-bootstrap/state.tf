resource "random_id" "suffix" {
  byte_length = 8
}


resource "aws_s3_bucket" "tf_state" {
  bucket = "terraform-state-file-${random_id.suffix.hex}"
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "state_file_lifecycle" {

  depends_on = [
    aws_s3_bucket_versioning.tf_state_versioning
  ]

  bucket = aws_s3_bucket.tf_state.id

  rule {
    id = "noncurrent_version_expiration"

    noncurrent_version_expiration {
      newer_noncurrent_versions = 100
      noncurrent_days = 1
    }

    status = "Enabled"
  }
}