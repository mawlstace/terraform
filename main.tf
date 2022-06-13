provider "aws" {
  region = "eu-west-2"
}

resource "aws_iam_user" "user" {
  name = "mawlsta"
}

resource "aws_iam_policy" "user-policy" {
  name = "user-policy"
 policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:list*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "policy-binding" {
  name = "attachment"
  users = [aws_iam_user.user.name]
  policy_arn = aws_iam_policy.user-policy.arn
}