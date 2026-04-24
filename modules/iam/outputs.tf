output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "IAM Role ARN"
}

output "role_name" {
  value = aws_iam_role.this.name
  description = "IAM role name"
}