#!/bin/bash

set -e

current_folder=$(pwd)
cd standalone

terraform init

terraform apply \
  -var-file ../aks.tfvars \
  -var-file ../acr.tfvars \
  -var-file ../configuration.tfvars \
  -var-file ../networking.tfvars \
  -var-file ../keyvault.tfvars \
  -var-file ../vm.tfvars \
  -var tags='{testing_job_id="${1}"}' \
  -var var_folder_path=${current_folder} \
  -var random_length=6 \
  -input=false \
  -auto-approve


terraform destroy \
  -var-file ../aks.tfvars \
  -var-file ../acr.tfvars \
  -var-file ../configuration.tfvars \
  -var-file ../networking.tfvars \
  -var-file ../keyvault.tfvars \
  -var-file ../vm.tfvars \
  -var tags='{testing_job_id="${1}"}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve

