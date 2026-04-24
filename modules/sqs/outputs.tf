output "queue_url" {
  value = aws_sqs_queue.this.id
  description = "SQS queue URL"
}

output "queue_arn" {
  value = aws_sqs_queue.this.arn
  description = "SQS Queue ARN"
}