output "job_name" {
  value = aws_glue_job.this.name
  description = "Glue job name"
}

output "job_arn" {
  value = aws_glue_job.this.arn
  description = "Glue job ARN"
}