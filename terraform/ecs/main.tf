provider "aws" {
  version = "~> 2.70"
  region  = "us-east-2"
}

resource "aws_ecs_cluster" "check_cluster" {
  name               = "check-cluster"
  capacity_providers = ["FARGATE_SPOT"]
}

// note: we'll probably want to move to separate definitions
// for each service check in the future
resource "aws_ecs_task_definition" "check_services" {
  family                = "check-services"
  container_definitions = file("./check-services.json")

  task_role_arn = aws_iam_role.ecs_role.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 512
  memory = 1024
}

output "check_services_task_definition_arn" {
  value = aws_ecs_task_definition.check_services.arn
}
