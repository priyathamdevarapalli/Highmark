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
          "iam:*",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:iam::974224957526:role/Admin-Role"
      },
    ]
  })
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"
  tags = {
    git_repo  = "Highmark"
    yor_trace = "28e9fa1e-7ea7-44e3-8bce-34713e2909dd"
  }
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}