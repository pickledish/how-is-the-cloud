provider "aws" {
  version = "~> 2.70"
  region  = "us-east-2"
}

resource "aws_ecs_cluster" "check_cluster" {
  name               = "check-cluster"
  capacity_providers = ["FARGATE_SPOT"]
}

resource "aws_ecs_task_definition" "check_s3" {
  family                = "service"
  container_definitions = file("./check-s3-definition.json")

  task_role_arn = aws_iam_role.ecs_role.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 512
  memory = 1024
}
