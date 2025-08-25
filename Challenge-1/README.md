# Challenge 1

## Initial code:
```
provider "aws" {
  version    = "~> 2.54"
  region     = "us-east-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

provider "digitalocean" {}

terraform {
  required_version = "0.12.31"
}

resource "aws_eip" "kplabs_app_ip" {
  vpc = true
}
```
### Note: The access_key and secret_key values used here are dummy placeholders and not valid credentials.

1. Create Infrastructure using the provided code (without modifications).

2. Verify if the code works in the latest version of Terraform and Provider .

3. Modify and Fix the code so that it works with latest version of Terraform.

4. Feel free to edit the code as you like.