resource "aws_lb" "test-alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http.id]
  subnets            = ["subnet-0ebe457ccbd20c958", "subnet-0440a7f8d02ddb610", "subnet-06f4381fc428ab3c3"]

  enable_deletion_protection = false

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws-lab.arn
  }
}

resource "aws_lb_target_group" "aws-lab" {
  name     = "test-app"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-019a34a441c703daf"
}


