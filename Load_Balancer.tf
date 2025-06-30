#Load_Balancer.tf
# Récupération des subnets publics
data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

resource "aws_lb" "BSE_LoadBalancer" {
  name               = "BSE-LoadBalancer"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.BSE_SecurityGroup_LB.id]
}

resource "aws_lb_target_group" "BSE_TargetGroup" {
  name     = "BSE-TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "BSE_Listener" {
  load_balancer_arn = aws_lb.BSE_LoadBalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.BSE_TargetGroup.arn
  }
}
