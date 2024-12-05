resource "aws_apigatewayv2_api" "api" {
  name          = var.api_name
  protocol_type = "HTTP"
}

resource "aws_lambda_function" "lambda" {
  function_name = "${var.api_name}-handler"
  runtime       = "python3.9"
  handler       = "handler.lambda_handler"
  filename      = var.lambda_zip
  role          = aws_iam_role.lambda_exec.arn
}

resource "aws_apigatewayv2_integration" "integration" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.lambda.arn
}


