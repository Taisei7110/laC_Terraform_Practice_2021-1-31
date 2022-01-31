resource "aws_lb" "tf-my-alb" {
  name                       = "test-alb-tf"
  internal                   = false
  enable_deletion_protection = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.tf-alb-sg.id]

  subnets = [
    aws_subnet.public-subnet-1a.id,
    aws_subnet.public-subnet-1c.id
  ]

  tags = {
    Name = "alb-terraform"
  }
}
//セキュリティグループの定義

resource "aws_security_group" "tf-alb-sg" {
  name   = "alb"
  vpc_id = aws_vpc.my-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-terraform"
  }
}

//ターゲットグループの定義

resource "aws_lb_target_group" "tf-alb-tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my-vpc.id


  health_check {
    interval            = 30
    path                = "/index.html"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

//ターゲットグループのアタッチ
resource "aws_alb_target_group_attachment" "tf-alb-tg-attach-a" {
  target_group_arn = aws_lb_target_group.tf-alb-tg.arn
  target_id        = aws_instance.tf-my-instance-a.id
  port             = 80
}

resource "aws_alb_target_group_attachment" "tf-alb-tg-attach-c" {
  target_group_arn = aws_lb_target_group.tf-alb-tg.arn
  target_id        = aws_instance.tf-my-instance-c.id
  port             = 80
}

//ALBのリスナーの定義
resource "aws_alb_listener" "tf-alb-listener" {
  load_balancer_arn = aws_lb.tf-my-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-alb-tg.arn
  }
}

//リスナールールの定義
resource "aws_alb_listener_rule" "tf-listener-rule" {
  listener_arn = aws_alb_listener.tf-alb-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-alb-tg.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}