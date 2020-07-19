provider "aws" {
  version = "~> 2.70"
  region  = "us-east-2"
}

resource "aws_cloudwatch_event_rule" "every_five_minutes" {
  name        = "every-five-minutes"
  description = "A rule that fires every five minutes"

  is_enabled          = true
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "check_cloudflare" {
  target_id = "check-cloudflare"
  arn       = "arn:aws:ecs:us-east-2:880716778824:cluster/check-cluster"
  rule      = aws_cloudwatch_event_rule.every_five_minutes.name
  role_arn  = aws_iam_role.cloudwatch_role.arn

  ecs_target {
    launch_type      = "FARGATE"
    platform_version = "1.4.0"

    task_count          = 1
    task_definition_arn = "arn:aws:ecs:us-east-2:880716778824:task-definition/check-cloudflare-task:1"

    network_configuration {
      subnets          = data.aws_subnet_ids.default.ids
      security_groups  = [aws_security_group.allow_all_outbound.id]

      # These containers need to speak to the internet, so give them IP addresses
      assign_public_ip = true
    }
  }
}
