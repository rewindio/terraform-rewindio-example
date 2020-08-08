bucket               = "terraformramyabucket"
key                  = "terraform.tfstate"
workspace_key_prefix = "terraform-workspaces"
dynamodb_table       = "terraformlockramya02"
region               = "ap-southeast-2"
profile              = "default"

external_ip_allow_list = [""]