###################################################################
## Application Load Balancer
##################################################################
resource "aws_lb" "applications_load_balancer" {
  name                             = var.application_load_balancer_name
  internal                         = var.internal_or_internet_facing
  load_balancer_type               = var.loadBalancer_type
  security_groups                  = var.security_group_id
  idle_timeout                     = var.timeout_idle_alb
  subnets                          = var.public_subnet_ids
  tags = {
    Environment = var.alb_environment_tag
  }
}