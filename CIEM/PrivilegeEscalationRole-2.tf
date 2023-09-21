resource "aws_iam_policy" "policy" {
  name        = "privilegeEscalation_policy-2"
  description = "My test policy-2"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}