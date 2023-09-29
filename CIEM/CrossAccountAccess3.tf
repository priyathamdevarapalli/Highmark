resource "aws_iam_role" "test_role" {
  name = "test_role"

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
          AWS = "arn:aws:iam::974224957526:root"
        }
      }
    ]
    }
  )

  tags = {
    tag-key   = "tag-value"
    git_repo  = "Highmark"
    yor_trace = "3b2c388b-9c35-4ec5-bc18-189724e8b998"
  }
}