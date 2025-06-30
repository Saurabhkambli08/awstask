variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID for ECS/ALB"
  type        = string
}

variable "subnets" {
  description = "Subnets for ECS tasks and ALB"
  type        = list(string)
}

variable "app_image_tag" {
  description = "Tag for app image"
  type        = string
  default     = "latest"
}

variable "nginx_image_tag" {
  description = "Tag for nginx image"
  type        = string
  default     = "latest"
}

variable "desired_count" {
  description = "Number of tasks"
  type        = number
  default     = 2
}

# variable "db_username" {}
# variable "db_password" {}
# variable "domain_name" {}