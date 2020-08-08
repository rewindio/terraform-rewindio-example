# terraform-rewindio-example

An example repo showing the general layout of most of our Terraform repos at Rewind and illustrating how the Terraform Github actions are configured.

This repo is an example to accompany the blog post [Automated Terraform Deployments to AWS with Github Actions](https://medium.com/@dnorth98/automated-terraform-deployments-to-aws-with-github-actions-c590c065c179)

## Usage

Create a backend.tfvars file with your backend configuration. It should look something like:

```hcl
bucket               = "terraform-state-bucket"
key                  = "terraform.tfstate"
workspace_key_prefix = "terraform-workspaces"
dynamodb_table       = "terraform_state_lock"
region               = "ap-southeast-2"
profile              = "production"

external_ip_allow_list = [""]
```

Instructions on configuring dynamoDB for state locking are in the [terraform docs](https://www.terraform.io/docs/backends/types/s3.html).  `profile` is the name of an AWS credentials profile that has access to the bucket for storing sate.

Once the workspace and backend file is configured, you can init and plan as usual

```bash
terraform init -backend-config ./backend.tfvars
terraform workspace new st-test-results-bucket_ap-southeast-2
terraform apply -var-file ./backend.tfvars -var-file tfvars/default/st-test-results-bucket_ap-southeast-2.tfvars
```

## Github actions

The `.github/workflows` folder contains the workflows for enabling terraform control via a github workflow.  It requires the following secrets be set on the repo

* `deploy_user_PAT` - this is a Github access token for a user that has read access to repos.  This handles the case where terraform private modules are being used
* `AWS_ACCESS_KEY_ID_default`, `AWS_SECRET_ACCESS_KEY_default`, `AWS_ACCESS_KEY_ID_PRODUCTION`, `AWS_SECRET_ACCESS_KEY_PRODUCTION` - AWS credentials for a default and production account

The **plan** workflow will trigger on any new pull request to the repo and run a plan for any workspaces specified in the matrix strategy

```yaml
    strategy:
      matrix:
        workspace: [st-test-results-bucket_ap-southeast-2,
                    pd-test-results-bucket_ap-southeast-2]
```

It expects to find tfvars files under `tfvars/default` or `tfvars/production` that match the names of the workspaces.

The **apply** workflow is triggered by comments to the pull request of the form

`terraform apply <directive>`

use `terraform help` as a pull request comment to see the available directives
