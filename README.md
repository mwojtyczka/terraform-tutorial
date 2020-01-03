# terraform-tutorial

This project shows how to use terraform for multi-environment and multi-app deployment.

# Developer workflow (local)

## go to the app you want to deploy
```
cd app1
```

## provide aws credentials
* linux
```
export TF_VAR_profile=tm6-dev
```

* windows
```
set TF_VAR_profile=tm6-dev
```

## deploy dev env
```
terraform init
terraform workspace new dev
terraform workspace select dev
terraform apply
terraform destroy
```

## deploy preprod env
```
terraform init
terraform workspace new preprod
terraform workspace select preprod
terraform apply
terraform destroy
```

## deploy prod env
```
export TF_VAR_profile=tm6-prod

terraform init
terraform workspace new prod
terraform workspace select prod
terraform apply
terraform destroy
```

# CI/CD setup workflow
https://learn.hashicorp.com/terraform/development/running-terraform-in-automation
https://www.terraform.io/docs/providers/aws/index.html

## Provide credentials

* either use profile
```
export TF_VAR_profile=tm6-dev
```

* or env vars
```
export AWS_ACCESS_KEY_ID=accesskey
export AWS_SECRET_ACCESS_KEY=secretkey
```
```
export TF_IN_AUTOMATION=enabled
terraform init
```

## init with s3 backend
```
terraform init \
    -backend-config="bucket=dev-terraform-state-tm6-vorwerk" \
    -backend-config="key=app1/terraform.tfstate" \
    -backend-config="region=eu-central-1" \
    -backend-config="profile=tm6-dev"
```

## deploy env
```
terraform workspace new dev
terraform workspace select dev # export TF_WORKSPACE=dev
terraform apply -input=false -auto-approve
terraform destroy -auto-approve
```
