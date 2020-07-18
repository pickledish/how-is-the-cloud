# -----------------------------------------------------------------------------
# Definitions for IAM roles and policies for ECS tasks to use
# -----------------------------------------------------------------------------

# who can assume this role when they want to?
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

# what does this role allow you to perform?
data "aws_iam_policy" "ecs_events" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
}

# what does this role allow you to perform (part 2)?
resource "aws_iam_policy" "ecs_trigger" {
  name        = "cloudwatch-events-iam-policy"
  description = "Policy that allows for triggering ECS tasks"

  policy = data.aws_iam_policy.ecs_events.policy
}

resource "aws_iam_role" "cloudwatch_role" {
  name        = "cloudwatch-events-iam-role"
  description = "Role that allows Cloudwatch events to trigger ECS"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_events" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = aws_iam_policy.ecs_trigger.arn
}
