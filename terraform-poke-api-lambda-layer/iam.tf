data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    sid     = "LambdaAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_poke_role" {
  name               = "lambda_poke_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "create-logs-cw-lambda" {
  statement {
    sid       = "AllowCreateLogGroup"
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup"]
    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    sid       = "AllowWriteLogs"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]
  }
}

resource "aws_iam_policy" "create-logs-policy" {
  name   = "create-logs-policy"
  policy = data.aws_iam_policy_document.create-logs-cw-lambda.json
}

resource "aws_iam_role_policy_attachment" "poke_api_cw" {
  policy_arn = aws_iam_policy.create-logs-policy.arn
  role       = aws_iam_role.lambda_poke_role.name
}