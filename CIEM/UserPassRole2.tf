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
        Resource = "arn:aws:iam::974224957526:role/Test-CF-Role"
      },
    ]
  })
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"
  tags = {
    git_repo  = "Highmark"
    yor_trace = "bda8f7d5-644e-4535-9457-604ad169dc3c"
  }
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}