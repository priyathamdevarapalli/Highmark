resource "aws_iam_user" "userwithoutPB" {
  name                = "PB_user"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)
  managed_policy_arns = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn]
  tags = {
    git_repo  = "Highmark"
    yor_trace = "5490e6e4-6857-4a73-a303-f842f14936ca"
  }
}
