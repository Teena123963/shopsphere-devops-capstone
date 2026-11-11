
resource "aws_lb" "shopsphere" {
  name               = "shopsphere-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0c8b43c25da2b75cd"]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name    = "ShopSphere-ALB"
    Project = "ShopSphere"
  }
}

resource "aws_lb_target_group" "shopsphere_api" {
  name        = "shopsphere-api-tg"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.shopsphere_vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name    = "ShopSphere-API-TG"
    Project = "ShopSphere"
  }
}

resource "aws_lb_listener" "shopsphere_http" {
  load_balancer_arn = aws_lb.shopsphere.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.shopsphere_api.arn
  }
}
