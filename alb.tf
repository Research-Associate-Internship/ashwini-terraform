resource "aws_lb" "rac3-hashicorp" {
  name               = "hashicorp-ALB"
  internal           = false
  load_balancer_type = "application"

  security_groups = ["sg-04a52f85b9f0df4c8"]

  subnets = [
    "subnet-0860b49c7e7abaa7a",
    "subnet-0466b06d40b97619e"
  ]

}

resource "aws_lb_target_group" "rac3-hashicorp" {
  name     = "hashicorp-TG"
  port     = 8200
  protocol = "HTTP"
  vpc_id   = "vpc-005db026359877d5e"

  health_check {
    path = "/"
  }

}

#instance must be running to attach
resource "aws_lb_target_group_attachment" "rac3-hashicorp-attach" {
  target_group_arn = aws_lb_target_group.rac3-hashicorp.arn
  target_id        = aws_instance.Hashicorp-instance.id
  port             = 8200
}

resource "aws_lb_listener" "hashicorp-tg" {
  load_balancer_arn = aws_lb.rac3-hashicorp.arn
  port              = "8200"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "hashicorp-tg-443" {
  load_balancer_arn = aws_lb.rac3-hashicorp.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-1:853931821519:certificate/940dc7b3-c7ab-45fe-b3e7-7922417bf171"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rac3-hashicorp.arn
  }
}
