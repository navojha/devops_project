variable "cloudwatch_role_name" {
  description = "CloudWatch log role"
  type        = string
  default = "cloudwatch_log_role"
}

variable "cloudwatch_policy_name" {
  description = "CloudWatch log policy"
  type        = string
  default = "cloudwatch_log_policy"
}

variable "policy_attachment_name" {
  description = "cloudwatch policy attachment name"
  type        = string
  default = "cloudwatch_policy_attachment"
}

variable "ec2_log_group_name" {
  description = "Log group name"
  type        = string
  default = "log_to_cloudwatch"
}

variable "instance_profile_name" {
  description = "instance profile name"
  type        = string
  default = "cloudwatch_log_instance_profile"
}

variable "retention" {
  description = "Log retention period in days"
  type        = number
  default     = 30
}