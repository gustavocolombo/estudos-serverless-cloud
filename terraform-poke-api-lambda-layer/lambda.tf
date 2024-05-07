data "archive_file" "poke_api_function_zip" {
  output_path = "files/poke_api_artefact.zip"
  type        = "zip"
  source_file = "${local.lambdas_path}/api/index.js"
}

resource "aws_lambda_function" "poke_api_lambda" {
  function_name    = "poke_api_lambda"
  handler          = "index.handler"
  role             = aws_iam_role.lambda_poke_role.arn
  filename         = data.archive_file.poke_api_function_zip.output_path
  source_code_hash = data.archive_file.poke_api_function_zip.output_base64sha256
  runtime          = "nodejs16.x"

  layers = [aws_lambda_layer_version.lambda_layer_poke.arn]

  timeout     = 5
  memory_size = 128
}