resource "aws_ecr_repository" "myself_rds_kinesis_dev_repo" {
  name                 = "${var.app_name}-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name        = "${var.app_name}-repo"
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  repository = aws_ecr_repository.myself_rds_kinesis_dev_repo.name

  policy = templatefile("policies/ecr_policy.json", { untagged_retention = 7, tagged_retention = 30 })
}