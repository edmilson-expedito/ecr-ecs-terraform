terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "= 3.1.3"
    }
    template = {
      source  = "hashicorp/template"
      version = "= 2.2.0"
    }
  }
}
provider "aws" {
  region     = "us-east-1"
}