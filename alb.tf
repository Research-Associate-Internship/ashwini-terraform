resource "aws_lb" "rac3-hashicorp" {
  name               = "hashicorp-ALB"
  internal           = false
  load_balancer_type = "application"

  security_groups = ["sg-04a52f85b9f0df4c8"]
  subnets =["subnet-0860b49c7e7abaa7a","subnet-0466b06d40b97619e","subnet-0f2c70f65b8db52ff","subnet-0bc69b49810210192"]

}

resource "aws_lb_target_group" "rac3-hashicorp" {
  name     = "hashicorp-TG"
  port     = 8200
  protocol = "HTTP"
  vpc_id   = "vpc-005db026359877d5e"

  health_check {
    path = "/login"
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
  port              = "80"
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
  certificate_arn   = "arn:aws:acm:us-east-1:853931821519:certificate/e2da0f86-f6cb-4252-b68f-92785c07613b"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rac3-hashicorp.arn
  }
}
