provider "aws" {
  version = "~> 2.70"
  region  = "us-east-2"
}

resource "aws_ecs_cluster" "check_cluster" {
  name               = "check-cluster"
  capacity_providers = ["FARGATE_SPOT"]
}

resource "aws_ecs_task_definition" "check_cloudflare" {
  family                = "check-cloudflare-task"
  container_definitions = file("./check-cloudflare-definition.json")

  task_role_arn = aws_iam_role.ecs_role.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 256
  memory = 512
}

output "check_cloudflare_task_definition_arn" {
  value = aws_ecs_task_definition.check_cloudflare.arn
}
