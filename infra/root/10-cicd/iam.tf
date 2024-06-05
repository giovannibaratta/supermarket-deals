resource "aws_iam_role" "code_build" {
  name               = "code-build"
  assume_role_policy = data.aws_iam_policy_document.code_build_assume_role.json
}

# Attach policy to role
resource "aws_iam_role_policy" "code_build" {
  role   = aws_iam_role.code_build.name
  policy = data.aws_iam_policy_document.code_build.json
}

# Allows Code Build to use the role
data "aws_iam_policy_document" "code_build_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "code_build" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.code_build_logs.arn,
      "${aws_s3_bucket.code_build_logs.arn}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }
}