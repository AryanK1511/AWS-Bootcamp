terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
} 

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA12345"
  secret_key = "Bo6ri+12345"
}

// the syntax for creating a resource is:
// resource "PROVIDER_TYPE" "RESOURCE_NAME" {

resource "aws_instance" "test" {
  ami           = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
}