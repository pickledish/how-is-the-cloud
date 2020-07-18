provider "aws" {
  version = "~> 2.70"
  region  = "us-east-2"
}

resource "aws_dynamodb_table" "history_table" {
  name         = "History"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ServiceId"
  range_key    = "CheckTime"

  # The ID of the thing we're checking on
  attribute {
    name = "ServiceId"
    type = "S"
  }

  # The epoch second that we finished the check
  attribute {
    name = "CheckTime"
    type = "N"
  }

  ttl {
    enabled        = true
    attribute_name = "ExpireTime"
  }
}

output "history_table_arn" {
  value = aws_dynamodb_table.history_table.arn
}
