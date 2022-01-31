/* //起動設定の定義
resource "aws_launch_template" "autoscaling-setting" {
  name_prefix            = "foobar"
  image_id               = "ami-02892a4ea9bfa2192"
  instance_type          = "t2.micro"
  key_name               = "id_rsa_terraform"
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
}



//ASGの定義
resource "aws_autoscaling_group" "tf-asg" {
  name                      = "tf-asg-test"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1c.id]
  target_group_arns         = ["${aws_lb_target_group.tf-alb-tg.arn}"]

  launch_template {
    id      = aws_launch_template.autoscaling-setting.id
    version = "$Latest"
  }

}


//オートスケーリングとALBのアタッチ
resource "aws_autoscaling_attachment" "asg_attachment_ALB" {
  autoscaling_group_name = aws_autoscaling_group.tf-asg.id
  alb_target_group_arn   = aws_lb_target_group.tf-alb-tg.arn
}

//スケールポリシーの設定
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "Instance-ScaleOut-CPU-High"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tf-asg.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "Instance-ScaleIn-CPU-Low"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tf-asg.name
}

//スケールスケジュールの設定
resource "aws_cloudwatch_metric_alarm" "alarm-high" {
  alarm_name          = "CPU-Utilization-High-30"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.tf-asg.name}"
  }
  alarm_actions = ["${aws_autoscaling_policy.scale_out.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "alarm-low" {
  alarm_name          = "CPU-Utilization-Low-5"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "5"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.tf-asg.name}"
  }
  alarm_actions = ["${aws_autoscaling_policy.scale_in.arn}"]
}
 */

