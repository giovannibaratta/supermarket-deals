resource "aws_s3_bucket" "flyer_staging" {
  bucket = "flyer-staging-${local.suffix}"
}

resource "aws_s3_bucket_notification" "flyers_created" {
  bucket = aws_s3_bucket.flyer_staging.id

  queue {
    queue_arn     = aws_sqs_queue.flyers.arn
    events        = ["s3:ObjectCreated:*"]
  }
}