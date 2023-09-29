resource "aws_iam_role" "Untrusted-accounts" {
  name = "Untrusted-accounts"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "758313975162"
        }
      },
    ]
  })

  tags = {
    tag-key   = "tag-value"
    git_repo  = "Highmark"
    yor_trace = "d6ca92dc-7e9e-4e3a-a83f-b3a3b7b7c410"
  }
}

