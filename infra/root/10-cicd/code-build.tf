resource "aws_codebuild_project" "backend" {
  name          = "supermarket-deals-backend"
  description   = "Build a container for the supermarket-deals backend application"
  build_timeout = 5
  service_role  = aws_iam_role.code_build.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.code_build_logs.id}/build-log"
    }
  }

  source {
    type            = "GITHUB"
buildspec = "backend/buildspec.yaml"

    location        = "https://github.com/giovannibaratta/supermarket-deals.git"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = false
    }
  }

  source_version = "main"

  vpc_config {
    vpc_id = aws_vpc.cicd.id

    subnets = [
      aws_subnet.code_build.id,
    ]

    security_group_ids = [
      aws_security_group.code_build.id,
    ]
  }
}