resource "aws_lambda_function" "this" {
    function_name = var.function_name
    role = var.role_arn
    handler = var.handler
    runtime = var.runtime
    timeout = var.timeout
    filename = var.filename
    source_code_hash = filebase64sha256(var.filename)

    environment {
      variables = {
        DATA_BUCKET = var.s3_bucket
        SQS_QUEUE_URL = var.sqs_queue_url
      }
    }
}
