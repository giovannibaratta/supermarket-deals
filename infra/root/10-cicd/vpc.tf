resource "aws_vpc" "cicd" {
  cidr_block = "10.255.255.0/24"

  tags = {
    Name = "cicd"
  }
}

resource "aws_subnet" "code_build" {
  vpc_id     = aws_vpc.cicd.id
  cidr_block = "10.255.255.0/27"
  availability_zone = "${var.primary_region}a"
}

resource "aws_security_group" "code_build" {
  name        = "code-build"
  description = "Security group for code build"
  vpc_id      = aws_vpc.cicd.id
}