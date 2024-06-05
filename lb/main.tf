resource "aws_lb" "lb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnet_id            =  "var.private_subnet_id"

  enable_deletion_protection = true
}
  # listener

  resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# target group

resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# target group attachment

resource "aws_lb_target_group_attachment" "tga" {
  count = length(var.my_instance)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.my_instance[count.index]
  port             = 80
}

