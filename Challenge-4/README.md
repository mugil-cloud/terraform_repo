
## Terraform IAM User Creation and Enumeration – Documentation

### Objective
This Terraform configuration achieves three key goals:
1. **Creates an IAM user** with the naming convention `admin-user-{AWS Account ID}`.
2. **Retrieves and displays all IAM user names** in the AWS account.
3. **Outputs the total number of IAM users**.

---

### File: `providers.tf`

#### Terraform Provider Configuration
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

- **Purpose**: Declares the AWS provider dependency using HashiCorp's registry.
- **Version Pinning**: Ensures compatibility and stability by locking to version `~> 6.0`.

#### 🌍 AWS Provider Setup
```hcl
provider "aws" {
  region = "us-east-1"
}
```

- **Region**: Specifies `us-east-1` as the default AWS region for all resources.
- **Scalability Note**: Can be modularized later to support multiple regions via variables.

---

### File: `aws_iam.tf`

#### Data Source: AWS Account Identity
```hcl
data "aws_caller_identity" "current" {}
```

- **Purpose**: Fetches metadata about the current AWS account.
- **Used For**: Dynamically injects the account ID into the IAM username.

#### IAM User Resource
```hcl
resource "aws_iam_user" "aws_user" {
  name = "admin-user-${data.aws_caller_identity.current.account_id}"
}
```

- **Dynamic Naming**: Constructs the IAM username using the format `admin-user-{account_id}`.
- **Client Requirement #1 Fulfilled**: Ensures uniqueness across accounts and aligns with naming convention.

#### Data Source: IAM Users List
```hcl
data "aws_iam_users" "aws_users" {}
```

- **Purpose**: Retrieves metadata for all IAM users in the account.
- **Client Requirement #2 Fulfilled**: Enables listing of all user names.

#### Output: List of IAM User Names
```hcl
output "list_users" {
  value = data.aws_iam_users.aws_users.names
}
```

- **Functionality**: Displays all IAM usernames in the Terraform output.
- **Use Case**: Useful for audits, onboarding visibility, or automation pipelines.

#### Output: Total Number of IAM Users
```hcl
output "list_users_count" {
  value = length(data.aws_iam_users.aws_users.names)
}
```

- **Functionality**: Calculates and displays the total number of IAM users.
- **Client Requirement #3 Fulfilled**: Provides a quick summary metric.

---

### Summary of Achievements

| Requirement                              | Status | Implementation Detail |
|------------------------------------------|----------|------------------------|
| Create IAM user with account-based name  | Completed     | `admin-user-${account_id}` |
| List all IAM users                       | Completed     | `data.aws_iam_users.aws_users.names` |
| Show total number of IAM users           | Completed       | `length(data.aws_iam_users.aws_users.names)` |