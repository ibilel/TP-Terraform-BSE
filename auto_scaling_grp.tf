resource "aws_autoscaling_group" "BSE_AutoScalingGroup" {
  name                      = "BSE-AutoScalingGroup"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  vpc_zone_identifier       = data.aws_subnets.default.ids
  health_check_type         = "EC2"
  health_check_grace_period = 300
  target_group_arns         = [aws_lb_target_group.BSE_TargetGroup.arn]

  launch_template {
    id      = aws_launch_template.BSE_LaunchTemplate.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "BSE-Instance"
    propagate_at_launch = true
  }
}
