variable "job_name" {
  description = "Glue job name"
  type = string
}

variable "role_arn" {
  description = "IAM role ARN for the Glue job"
  type = string
}

variable "script_location" {
  description = "S3 path to ETL script"
  type = string
}

variable "temp_dir" {
  description = "Temporary directory in S3 for Glue Job"
  type = string
}

variable "worker_type" {
  description = "Glue Worker Type"
  type = string
}

variable "number_of_workers" {
  description = "Number of Glue workers"
}

variable "glue_version" {
  description = "Glue Version"
}

variable "timeout" {
  description = "Timeout for the Glue Job"
}

variable "max_retries" {
  description = "Max retries"
  type = number
  default = 1
}

variable "default_arguments" {
  description = "Extra default arguments for Glue job"
  type = map(string)
}