#!/bin/bash

set -e

current_folder=$(pwd)
cd standalone

terraform init

terraform apply \
  -var-file ../container_groups.tfvars \
  -var-file ../global_settings.tfvars \
  -var-file ../resource_groups.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../managed_identities.tfvars \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve


terraform destroy \
  -var-file ../container_groups.tfvars \
  -var-file ../global_settings.tfvars \
  -var-file ../resource_groups.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../managed_identities.tfvars \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve

