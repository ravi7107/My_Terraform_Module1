#Autoscalling launch configuration
resource "aws_launch_configuration" "levelup_launch_config" {
    name_prefix = "levelup_launch_config"
    image_id = lookup(var.ami_id, var.region)
    instance_type = "t2.micro"
    key_name = aws_key_pair.levelup_key.key_name
}

#Generate Key

resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.levelup_key_pub)
  
}

#Autoscalling group

resource "aws_autoscaling_group" "levelup_autoscalling" {

    vpc_zone_identifier = [ "us-east-2b", "us-east-2b" ]
    launch_configuration = aws_launch_configuration.levelup_launch_config.name
    min_size = 1
    max_size = 2
    health_check_grace_period = 200
    health_check_type = "EC2"
    force_delete = "true"

    tag {
      key = "Name"
      value = "Level up custom EC2 instance"
      propagate_at_launch = true

    }
}

#Autoscalling configuration policy- Scaling alarm
resource "aws_autoscaling_policy" "levelup_cpu-policy" {
    autoscaling_group_name = aws_autoscaling_group.levelup_autoscalling.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = "1"
    cooldown ="200"
    policy_type = "SimpleScaling"

}

#Autoscalling cloud watch monitoring

resource "aws_cloudwatch_metric_alarm" "levelup_cpu_alarm" {
  alarm_name                = "levelup_cpu_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = "30"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    "AutoscalingGroupName"=aws_autoscaling_group.levelup_autoscalling.name

  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.levelup_cpu-policy.arn]
}

#Auto Descalling configuration policy- Scaling alarm
resource "aws_autoscaling_policy" "levelup_cpu-policy_scaledown" {
    name = "levelup_cpu-policy_scaledown"
    autoscaling_group_name = aws_autoscaling_group.levelup_autoscalling.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = "-1"
    cooldown ="200"
    policy_type = "SimpleScaling"

}

#Auto de-scalling cloud watch monitoring

resource "aws_cloudwatch_metric_alarm" "levelup_cpu_alarm-scaledown" {
  alarm_name                = "levelup_cpu_alarm-scaledown"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    "AutoscalingGroupName"=aws_autoscaling_group.levelup_autoscalling.name

  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.levelup_cpu-policy_scaledown.arn]
}