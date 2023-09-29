resource "aws_iam_policy" "policy" {
  name        = "notAction_policy"
  path        = "/"
  description = "Not Action policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        NotAction = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "517f78e4-1490-493f-91c2-6cf3adf6aaae"
  }
}