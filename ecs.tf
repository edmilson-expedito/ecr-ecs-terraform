resource "aws_ecs_cluster" "myself_rds_kinesis_dev_cluster" {
  name = "white-hart"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "${var.app_name}-cluster"
  }
}

resource "aws_ecs_service" "myself_rds_kinesis_dev_service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.myself_rds_kinesis_dev_cluster.id
  task_definition = aws_ecs_task_definition.myself_rds_kinesis_dev_task.arn
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count   = 1
  force_new_deployment = true

  network_configuration {
    subnets          = aws_subnet.myself_rds_kinesis_dev_subnet.*.id
    assign_public_ip = false
    security_groups = [
      "sg-04af2fd73ab3ab254"
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.myself_rds_kinesis_dev_lb_target.arn
    container_name   = "${var.app_name}-container"
    container_port   = 8081
  }
}

resource "aws_ecs_task_definition" "myself_rds_kinesis_dev_task" {
  family = "Linux"
  
  container_definitions = jsonencode([
    {
      name      = "${var.app_name}-container"
      image     = "2305279726348302.dkr.ecr.us-east-1.amazonaws.com/myself-rds-kinesis-repository:latest"
      cpu       = 0
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8081
          hostPort      = 80
        }
      ]
    }
  ])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = "arn:aws:iam::2305279726348302:role/hub-cross"
  task_role_arn            = "arn:aws:iam::2305279726348302:role/hub-cross"
  
  tags = {
    Name        = "${var.app_name}-task"
  }
}