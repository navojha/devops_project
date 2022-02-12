######################################################
## Instance Target Group
######################################################

resource "aws_lb_target_group" "alb_target_group" {
  name     = "tg"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   =  var.vpc_id
  stickiness {
    type    = "lb_cookie"
    enabled = false
  }
  tags = {
    "Name" = "tg"
  }
}