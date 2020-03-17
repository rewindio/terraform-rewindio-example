provider "aws" {
  version = "~> 2.0"
  profile = var.aws_profile
  region  = local.aws_region
}

provider "aws" {
  version = "~> 2.0"
  alias   = "edge_provider"
  profile = var.aws_profile
  region  = "us-east-1"
}

# The backend config variables come from a backend.tfvars file
# which is not in this repo
terraform {
  backend "s3" {
  }
}

resource "aws_s3_bucket" "test_results" {
  bucket = var.test_results_bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    product     = "common"
    platform    = "common"
    bucket_name = var.test_results_bucket_name
  }
}
