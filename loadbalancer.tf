resource "aws_lb" "myself_rds_kinesis_dev_lb" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  subnets            = aws_subnet.myself_rds_kinesis_dev_subnet.*.id

  enable_deletion_protection = true

  tags = {
    Name        = "${var.app_name}-lb"
  }
}

resource "aws_lb_target_group" "myself_rds_kinesis_dev_lb_target" {
  name     = "${var.app_name}-lb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-e2199884"
}