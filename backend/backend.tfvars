bucket               = "terraform-state-bucket"
key                  = "terraform.tfstate"
workspace_key_prefix = "terraform-workspaces"
dynamodb_table       = "terraform_state_lock"
region               = "us-east-1"
profile              = "staging"

external_ip_allow_list = [""]