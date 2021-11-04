resource "aws_security_group" "http" {
  name        = "allow_http"
  description = "Allow inbound http traffic"
  vpc_id      = var.vpc_id

}

resource "aws_security_group_rule" "http-in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.http.id
}

resource "aws_security_group_rule" "http-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.http.id
}

# instance SG

resource "aws_security_group" "ec2-http" {
  name        = "allow_http to ec2"
  description = "Allow inbound http traffic"
  vpc_id      = var.vpc_id

}

resource "aws_security_group_rule" "ec2-http-in" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.http.id
  security_group_id        = aws_security_group.ec2-http.id
}

resource "aws_security_group_rule" "ec2-http-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ec2-http.id
}
