# terraform-tutorial

A great step by step tutorial is published here:
https://learn.hashicorp.com/terraform/getting-started/install.html

This sample terraform project is meant to show a complete setup for multi-environment and multi-app deployment. It is generic enough to be used as a starting point in real projects.

# Developer workflow (local)

## go to the app you want to deploy

```
cd app1 # or cd app2
# only envs defined by workspace_to_environment_map var are allowed
export ENV=dev
export PROFILE=dev
```

## provide aws credentials

```
export TF_VAR_profile=${PROFILE}
```

## deploy env

```
terraform init
terraform workspace new ${ENV}
#terraform workspace select ${ENV}
terraform apply
terraform destroy
```

# CI/CD workflow

Useful links:
https://learn.hashicorp.com/terraform/development/running-terraform-in-automation
https://www.terraform.io/docs/providers/aws/index.html

## Provide credentials

* via profile
```
export TF_VAR_profile=${PROFILE}
```

* or via env vars
```
export AWS_ACCESS_KEY_ID=accesskey
export AWS_SECRET_ACCESS_KEY=secretkey
```
```
export TF_IN_AUTOMATION=enabled
```

## init
```
# for local backend
terraform init

# for s3 backend
terraform init \
    -backend-config="bucket=<provide bucket>" \
    -backend-config="key=app1/terraform.tfstate" \
    -backend-config="region=eu-central-1" \
    -backend-config="profile=${PROFILE}"
```

## deploy env
```
terraform workspace new ${ENV}
#terraform workspace select ${ENV}
terraform apply -input=false -auto-approve
terraform destroy -auto-approve
```
