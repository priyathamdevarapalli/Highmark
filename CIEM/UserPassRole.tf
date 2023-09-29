resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.lb.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:PassRole",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"
  tags = {
    git_repo  = "Highmark"
    yor_trace = "4c4a5aba-97b2-4fbb-a568-ff5de16fd066"
  }
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}