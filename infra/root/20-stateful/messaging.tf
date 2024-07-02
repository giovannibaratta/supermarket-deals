locals {
  flyers_queue_name = "s3-flyers-${local.suffix}"
}

resource "aws_sqs_queue" "flyers" {
  name                      = local.flyers_queue_name
  message_retention_seconds = 1209600 # 14 days
  policy = data.aws_iam_policy_document.flyers_queue.json
}

data "aws_iam_policy_document" "flyers_queue" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:*:*:${local.flyers_queue_name}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.flyer_staging.arn]
    }
  }
}