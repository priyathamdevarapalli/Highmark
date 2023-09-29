resource "aws_iam_policy" "policy" {
  name        = "privilegeEscalation_policy-3"
  description = "My test policy-3"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:*",

        Effect   = "Allow"
        Resource = "arn:aws:iam::974224957526:role/Test-AdminAccess"
      },
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "0752f747-5a22-4107-878e-81ce41195b23"
  }
}