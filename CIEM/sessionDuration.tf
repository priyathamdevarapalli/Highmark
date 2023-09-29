resource "aws_iam_role" "session_durtion" {
  name                 = "yak_role"
  assume_role_policy   = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)
  managed_policy_arns  = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn]
  max_session_duration = "7200"
  tags = {
    git_repo  = "Highmark"
    yor_trace = "0fc5fb51-7c36-4083-81b3-cce148f89118"
  }
}

resource "aws_iam_policy" "policy_one" {
  name = "policy-618033"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
  tags = {
    git_repo  = "Highmark"
    yor_trace = "49442144-55ea-4bc1-80e5-0a24ea794baa"
  }
}