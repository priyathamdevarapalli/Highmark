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
          Service = "ec2.amazonaws.com"
          Condition = {
            StringEquals = {
              "sts:ExternalId" = "111111111111"
            }
          }
        }
      }
    ]
    }
  )

  tags = {
    tag-key   = "tag-value"
    git_repo  = "Highmark"
    yor_trace = "844ef9c4-6771-485b-9f59-9d24694a3aea"
  }
}