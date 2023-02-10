terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "developers_users" {
  count = 2
  name  = "dev_${count.index}"
}

resource "aws_iam_group_membership" "developers_group" {
  name = "tf-developers_group"

  users = [
    aws_iam_user.developers_users[0].name,
    aws_iam_user.developers_users[1].name,
  ]

  group = aws_iam_group.developers.name
}


resource "aws_iam_group_policy" "developers_policy" {
  name  = "developers_policy"
  group = aws_iam_group.developers.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}