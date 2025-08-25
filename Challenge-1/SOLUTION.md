# Solution 1

1. Create Infrastructure using the provided code (without modifications).

```
To achieve this goal, I downloaded the required Terraform version 0.12.31 from  https://releases.hashicorp.com/terraform/0.12.31/ for macOS and executed the terraform init command using the downloaded executable:

./terraform init

#   Note: I used ./ to explicitly reference the required version from the local executable file.

#   Output
(base) 2025-08-25 13:34:24 challenge-1 (main) $ ./terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "digitalocean" (terraform-providers/digitalocean) 2.66.0...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.70.4...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.digitalocean: version = "~> 2.66"


Warning: registry.terraform.io: For users on Terraform 0.13 or greater, this provider has moved to digitalocean/digitalocean. Please update your source in required_providers.


Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.


(base) 2025-08-25 13:47:19 challenge-1 (main) $ ./terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.kplabs_app_ip will be created
  + resource "aws_eip" "kplabs_app_ip" {
      + allocation_id     = (known after apply)
      + association_id    = (known after apply)
      + customer_owned_ip = (known after apply)
      + domain            = (known after apply)
      + id                = (known after apply)
      + instance          = (known after apply)
      + network_interface = (known after apply)
      + private_dns       = (known after apply)
      + private_ip        = (known after apply)
      + public_dns        = (known after apply)
      + public_ip         = (known after apply)
      + public_ipv4_pool  = (known after apply)
      + vpc               = true
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

### As a security best practice, I configured AWS credentials using the AWS CLI and removed hardcoded values from the Terraform configuration file. This ensures sensitive information is not exposed in version control.


2. Verify if the code works in the latest version of Terraform and Provider .

3. Modify and Fix the code so that it works with latest version of Terraform.

4. Feel free to edit the code as you like.

```
To ensure compatibility with the latest Terraform version and resolve the following error:

Error: Unsupported Terraform Core version
│ 
│   on tf-challenge-1.tf line 11, in terraform:
│   11:   required_version = "0.12.31"
│ 
│ This configuration does not support Terraform version 1.13.0. To proceed, either choose another supported Terraform version or update this version constraint. Version constraints are normally set for good reason, so updating the constraint may lead to other errors or unexpected behavior.

## required_version = "1.13.0"

## Additionally, to address deprecation warnings related to provider version constraints inside provider blocks (deprecated since Terraform 0.13), I removed the version parameter from the provider block and moved it to the required_providers block as shown below:

│ Warning: Version constraints inside provider configuration blocks are deprecated
│ 
│   on tf-challenge-1.tf line 2, in provider "aws":
│    2:   version    = "~> 2.54"
│ 
│ Terraform 0.13 and earlier allowed provider version constraints inside the provider configuration block, but that is now deprecated and will be removed in a future version of Terraform. To
│ silence this warning, move the provider version constraint into the required_providers block.
│ 
│ (and one more similar warning elsewhere)
╵
╷
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider hashicorp/digitalocean: provider registry registry.terraform.io does not have a provider named
│ registry.terraform.io/hashicorp/digitalocean
│ 
│ Did you intend to use digitalocean/digitalocean? If so, you must specify that source address in each module which requires that provider. To see which modules are currently depending on
│ hashicorp/digitalocean, run the following command:
│     terraform providers


### Final code
provider "aws" {
  region     = "us-east-1"
}

provider "digitalocean" {}

terraform {
  required_version = "1.13.0"
  required_providers {
    aws = {
      version = "~>2.54"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "aws_eip" "kplabs_app_ip" {
  vpc = true
}
```


