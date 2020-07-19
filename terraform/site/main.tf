# -----------------------------------------------------------------------------
# Definitions for IAM access keys we'll allow the frontend to use
# -----------------------------------------------------------------------------

provider "aws" {
  version = "~> 2.70"
  region  = "us-east-2"
}

resource "aws_iam_user" "site_user" {
  name = "site"
}

resource "aws_iam_user_policy" "site_allow_read_dynamodb" {
  name = "site-allow-read-dynamodb"
  user = aws_iam_user.site_user.name

  policy = file("./dynamodb-allow-read.json")
}

resource "aws_iam_access_key" "site_user" {
  user = aws_iam_user.site_user.name
}

output "site_user_access_key" {
  value = aws_iam_access_key.site_user.id
}

# Generally bad practice, but we don't persist state anywhere
output "site_user_secret_key" {
  value = aws_iam_access_key.site_user.secret
}
