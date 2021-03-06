###############################################################
## Application Load Balancer
###############################################################
variable "application_load_balancer_name" {
  description = "Name of the APplication Load Balancer"
  type        = string
  default     = "my-ALB"
}
variable "internal_or_internet_facing" {
  description = "Whether ALB should be internal or internet-facing-- True means internal & False means internet-facing"
  type        = bool
  default     = false
}

variable "alb_environment_tag" {
  description = "mention the environment name"
  type        = string
  default     = "test"
}
variable "loadBalancer_type" {
  description = "Mention the type of load balancer you need- 'application', 'network', 'gateway'"
  type        = string
  default     = "application"
}
variable "drop_invalid_header_alb" {
  description = "Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false)."
  type        = bool
  default     = false
}
variable "timeout_idle_alb" {
  description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application."
  type        = number
  default     = 60
}

variable "vpc_id" {
  type    = string
}

variable "security_group_id" {
  type    = list(any)
}

variable "public_subnet_ids" {
  type    = list(any)
}

