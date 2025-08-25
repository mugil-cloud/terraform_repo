resource "aws_eip" "example" {
  domain = "vpc"

  tags = {
    Name        = "payment_app_eip"
    Environment = "Production"
  }
}