# Terraform Deploy Help

You can apply terraform plans by commenting on this PR using the following syntax:

* `terraform help` - Display this help
* `terraform apply` - Apply all plans produced by the plan phase
* `terraform apply <specific workspace>` - apply only the plan for the named workspace
* `terraform apply staging` - apply all plans for the staging environment(s)
* `terraform apply production` - apply all plans for the production environment(s)
