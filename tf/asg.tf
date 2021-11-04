resource "aws_launch_template" "ec2-lab" {
  name_prefix            = "ec2-lab"
  image_id               = "ami-0e1d564aaa397ddad"
  instance_type          = "t3.nano"
  vpc_security_group_ids = [aws_security_group.ec2-http.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ec2-lab" {
  availability_zones   = ["eu-north-1c", "eu-north-1b", "eu-north-1a"]
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  name                 = "app-asg"
  enabled_metrics      = []
  load_balancers       = []
  suspended_processes  = []
  termination_policies = []

  launch_template {
    id      = aws_launch_template.ec2-lab.id
    version = aws_launch_template.ec2-lab.latest_version

  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 0
      instance_warmup        = 5
    }
    triggers = ["tag"]
  }

  lifecycle {
    create_before_destroy = true
  }

  target_group_arns = [aws_lb_target_group.aws-lab.arn]
}
