provider "aws" {
  region = var.aws_region
}

# Should be uncommented after backend.tf when though
terraform {
  backend "s3" {}
}
