resource "aws_iam_policy" "kms_action" {
  name        = "kms_action"
  description = "kms"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Action   = "kms:Decrypt",
        Resource = "*",
      }
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "c743029d-9347-4d4a-8ab2-3208175323eb"
  }
}
