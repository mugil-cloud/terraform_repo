# Solution

## 1. Introduced for_each for Dynamic Resource Creation

    for_each = var.instance_config

**Purpose:** Enables Terraform to create one EC2 instance per key in the instance_config map.

**Impact:**

If you add a new key (e.g., instance3), a new EC2 instance is created.

If you remove a key (e.g., instance2), the corresponding EC2 instance is destroyed.

**Challenge Solved:** This directly meets the requirement of creating/destroying EC2 instances based on the map content.

## 2. Used each.value to Access Nested Map Values

    ami           = each.value.ami
    instance_type = each.value.instance_type

**Purpose:** Extracts the ami and instance_type from each nested map.

**Impact:** Ensures each EC2 instance is configured with its specific settings.

# Supporting Changes in Other Files
**Split main.tf into Modular Files**

| File          | Purpose                                      |
|---------------|----------------------------------------------|
| `providers.tf`| Declares provider and region                 |
| `variables.tf`| Defines the `instance_config` variable       |
| `aws_ec2.tf`  | Contains the EC2 resource logic              |


**Benefit:**  Enhances readability, maintainability, and team collaboration.

