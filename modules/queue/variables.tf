variable "tags" {
  description = "Resource Tags"
  type = map(string)
  default = {}
}

variable "region" {
  description = "AWS region"
  type = string
}

variable "vpc_id" {
}

variable "subnet_ids" {
  type = list(string)
}

variable "delay_seconds" {
  default = 90
}

variable "max_message_size" {
  type        = string
  default = 2048
}

variable "message_retention_seconds" {
  default = 86400
}

variable "receive_wait_time_seconds" {
  default = 10
}