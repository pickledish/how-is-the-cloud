# -----------------------------------------------------------------------------
# Definitions for IAM roles and policies for ECS tasks to use
# -----------------------------------------------------------------------------

# who can assume this role when they want?
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# what does this role allow you to do?
resource "aws_iam_policy" "history_policy" {
  name        = "dynamodb-read-write-history-policy"
  description = "Allows read and write access to history table"

  policy = file("./dynamodb-allow-read-write.json")
}

resource "aws_iam_role" "ecs_role" {
  name        = "ecs-role"
  description = "Role for ECS containers to use"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_history_attachment" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = aws_iam_policy.history_policy.arn
}
