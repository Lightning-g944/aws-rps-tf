variable "function_name" {
  description = "Lambda function name"
  type = string
}

variable "role_arn" {
  description = "IAM role ARN for Lambda"
}

variable "handler" {
  description = "Lamda Handler"
}

variable "runtime" {
  description = "Lambda runtime"
  type = string
  default = "python3.10"
}

variable "timeout" {
  description = "Lambda timeout in seconds"
  type = number
  default = 60
}

variable "s3_bucket" {
  description = "S3 bucket used by lambda"
  type = string
}

variable "sqs_queue_url" {
  description = "SQS queue URL"
  type = string
}

variable "filename" {
  description = "Path to the Lambda deployment package"
  type = string
}