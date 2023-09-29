resource "aws_iam_role" "rolewithoutPB" {
  name                = "PB_role"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)
  managed_policy_arns = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn]
  tags = {
    git_repo  = "Highmark"
    yor_trace = "cf3bff23-e5bc-4873-adac-7267bcf8bbea"
  }
}
