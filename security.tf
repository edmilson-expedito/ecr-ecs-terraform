resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = var.vpc_id
  name   = "${var.app_name}-load-balancer-security-group"
  description     = "Load Balancer Security Group"

  ingress {
      from_port   = 8081
      to_port     = 8081
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic from the internet"
    }
  egress {
    description      = "Allow all outbound traffic to the internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  lifecycle {
    ignore_changes = [description]
  }
  tags = {
    Name        = "${var.app_name}-alb-sg"
  }
}