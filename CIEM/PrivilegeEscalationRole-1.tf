resource "aws_iam_policy" "policy" {
  name        = "privilegeEscalation_policy-1"
  description = "My test policy-1"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",

        Effect   = "Allow"
        Resource = "arn:aws:iam::974224957526:role/Test-AdminAccess"
      },
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "e0906ec3-0026-45f2-b182-b5e3416f0ecf"
  }
}

