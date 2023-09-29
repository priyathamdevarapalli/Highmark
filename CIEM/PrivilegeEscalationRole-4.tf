resource "aws_iam_policy" "policy" {
  name        = "privilegeEscalation_policy-4"
  description = "My test policy-4"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:*",

        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "31eae749-767e-4f17-8c7b-c0fcaeb3f884"
  }
}