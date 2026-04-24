variable "queue_name" {
    description = "Name of the SQS queue"
    type        = string
}

variable "visibility_timeout_seconds" {
    description = "visibility timeout for the queue"
    type = number
    default = 60
  
}

variable "tags" {
    description = "Tags for the SQS queue"
    type = map(string)
    default = {}
  
}