##Autoscaling Group
resource "aws_autoscaling_group" "PoC_autoscaling" {
  name                      = "PoC_autoscaling"
  max_size                  = 5
  min_size                  = 1
  health_check_type         = "ELB"    # optional
  desired_capacity          = 1
  target_group_arns = [aws_lb_target_group.Poc_TG.arn]

  vpc_zone_identifier       = [aws_subnet.Poc_Subnet_a.id,aws_subnet.Poc_Subnet_b.id,aws_subnet.Poc_Subnet_c.id]
  
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
}
##Scale UP 
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.PoC_autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"      # add one instance
  cooldown               = "300"    # cooldown period after scaling
}

#Scale Up Allarm 

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "scale-up-alarm"
  alarm_description   = "asg-scale-up-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "50"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.PoC_autoscaling.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up.arn]
}

#ScaleDown
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.PoC_autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

#Scale Down Alarm 

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "asg-scale-down-alarm"
  alarm_description   = "asg-scale-down-cpu-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.PoC_autoscaling.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}