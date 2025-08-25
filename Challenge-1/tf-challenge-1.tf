provider "aws" {
  region     = "us-east-1"
}

terraform {
  required_version = "1.13.0"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

resource "aws_eip" "kplabs_app_ip" {
  domain = "vpc"
}