variable "log_group_name" {
  description = "Name of CloudWatch log group"
  type = string
}

variable "retention_in_days" {
  description = "Log retention period"
  type = number
  default = 14
}

variable "tags" {
  description = "Tags for CloudWatch log group"
  type = map(string)
  default = {}
  }
