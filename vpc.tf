resource "aws_subnet" "myself_rds_kinesis_dev_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.60.0.0/16"

  tags = {
    Name        = "${var.app_name}-subnet"
  }
}