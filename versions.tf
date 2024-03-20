terraform {
  required_version = ">= 0.13.1"

  # backend "s3" {
  #   bucket  = "terraform-fiap-soat"
  #   key     = "state.tfstate"
  #   region  = "us-east-1"
  #   encrypt = true
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.41"
    }
    local = {
      source  = "hashicorp/local",
      version = ">=2.1.0"
    }
  }
}
