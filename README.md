# terraform-tutorial

A great step by step tutorial is published here:
https://learn.hashicorp.com/terraform/getting-started/install.html

This sample terraform project is meant to show a complete setup for multi-environment and multi-app deployment. It is generic enough to be used as a starting point in real projects.

## 1. Go to the app you want to deploy

```
cd app1 
# or cd app2
```

## 2. Provide aws credentials

```
# specify env, only envs defined by workspace_to_environment_map var are allowed
export ENV=dev

# specify aws profile
export TF_VAR_profile=dev

# or aws credentials 
export AWS_ACCESS_KEY_ID=accesskey
export AWS_SECRET_ACCESS_KEY=secretkey
```

# 3. Typical developer workflow (local)

```
terraform init
terraform workspace new ${ENV}
#terraform workspace select ${ENV}
terraform apply
terraform destroy
```

# 4. CI/CD workflow

Useful links:

* https://learn.hashicorp.com/terraform/development/running-terraform-in-automation
* https://www.terraform.io/docs/providers/aws/index.html


## de-emphasize specific commands to run
```
export TF_IN_AUTOMATION=enabled
```

## init
```
# for local backend (state stored in terraform.tfstate.d local dir) that could be, for instance, later pushed to a separate git state repo
terraform init

# for s3 backend (sate stored in s3)
terraform init \
    -backend-config="bucket=<provide bucket>" \
    -backend-config="key=app1/terraform.tfstate" \
    -backend-config="region=eu-central-1" \
    -backend-config="profile=${AWS_PROFILE}"
```

## deploy env
```
terraform workspace new ${ENV}
#terraform workspace select ${ENV}
terraform apply -input=false -auto-approve
terraform destroy -auto-approve
```
