data "aws_caller_identity" "current" {}

resource "aws_iam_user" "aws_user" {
  name = "admin-user-${data.aws_caller_identity.current.account_id}"
}

data "aws_iam_users" "aws_users" {}

output "list_users" {
  value = data.aws_iam_users.aws_users.names
}

output "list_users_count" {
  value = length(data.aws_iam_users.aws_users.names)
}