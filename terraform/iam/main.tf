provider "aws" {
  version = "~> 2.70"
  region  = "us-east-2"
}

resource "aws_iam_role" "ecs_role" {
  name        = "ecs-role"
  description = "Role for ECS containers to use"

  assume_role_policy = file("./assume-sts-role.json")
}

resource "aws_iam_policy" "read_write_policy" {
  name        = "dynamodb-read-write-history-policy"
  description = "Allows read and write access to history table"

  policy = file("./dynamodb-allow-read-write.json")
}

resource "aws_iam_role_policy_attachment" "ecs-history-attachment" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = aws_iam_policy.read_write_policy.arn
}

output "ecs_role_name" {
  value = aws_iam_role.ecs_role.name
}

output "ecs_role_arn" {
  value = aws_iam_role.ecs_role.arn
}
