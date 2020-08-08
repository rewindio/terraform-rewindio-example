#
# These vars come from a backend.tfvars file (not in this repo)
# Make sure you pass -var-file backend.tfsvars when planning
variable "bucket" {
}

variable "key" {
}

variable "workspace_key_prefix" {
}

# used for state locking
variable "dynamodb_table" {
}

variable "region" {
}

# Aws credentials profile
variable "profile" {
}

variable "external_ip_allow_list" {
}

#
# These vars come from an environment specific tfvars file under tfvars/
variable "aws_profile" {
}

variable "test_results22_bucket_name" {
}


locals {
  # all of our workspaces are named using the format envrionent_variable-text_aws-region
  # ex: st-test-results_ap-southeast-2, pd-test-results_ap-southeast-2
  terraform_workspace_components = split("_", terraform.workspace)

  aws_region = element(local.terraform_workspace_components, 1)
}