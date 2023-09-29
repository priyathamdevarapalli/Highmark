variable "lambda_function_name" {
  default = "lambda_function_name"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = var.lambda_function_name

  # ... other configuration ...
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
  ]
  tags = {
    git_repo  = "Highmark"
    yor_trace = "81cdc962-bb9e-44e5-9392-4240429fe447"
  }
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole",
        "logs:CreateLogStream",
      ],
      "Resource": "arn:aws:role",
      "Effect": "Allow"
    }
  ]
}
EOF
  tags = {
    git_repo  = "Highmark"
    yor_trace = "fd6c9bb7-eba7-460c-a5f4-f2269b6d0b84"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}