# hub (local state)
# login as sp_terraform_global
# terraform init -reconfigure -backend-config="path=./environments/hub/uks/hub-uks.tfstate"
# terraform fmt -recursive
# terraform validate
# terraform plan -var-file="environments/hub/uks/hub-uks.tfvars"
# terraform apply -var-file="environments/hub/uks/hub-uks.tfvars" -auto-approve
# terraform destroy -var-file="environments/hub/uks/hub-uks.tfvars"

# hub (remote state)
# login as sp_terraform_global
terraform init -reconfigure `
  -backend-config="resource_group_name=rg-hub-uks-01" `
  -backend-config="storage_account_name=sardzhubukstfstate" `
  -backend-config="container_name=iac-9-github" `
  -backend-config="key=hub-uks.tfstate" `
  -backend-config="use_azuread_auth=true"
terraform fmt -recursive
terraform validate
terraform plan -var-file="environments/hub/uks/hub-uks.tfvars"
terraform apply -var-file="environments/hub/uks/hub-uks.tfvars" -auto-approve
terraform destroy -var-file="environments/hub/uks/hub-uks.tfvars"

# git
git checkout -b feature/test-1255
# make change
git add .
git commit -m "minor change"
git push -u origin --all

# github pr validation
name: main-pr-validation
enforcement status: active
target branches: add target - main
branch rules: untick everything
require a pull request before merging: tick
- required approval: 0
- dismiss stale pull request approvals when new commits are pushed: tick
- allowed merge methods: squash
require status checks to pass: tick
- add: plan-hub-uks (and all other plan files)
