#!/bin/bash

set -e

current_folder=$(pwd)
cd standalone

terraform init

terraform apply \
  -var-file ../configuration.tfvars \
  -var-file ../nsg.tfvars\
  -var-file ../public-ip-addresses.tfvars \
  -var-file ../routes.tfvars \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve


terraform destroy \
  -var-file ../configuration.tfvars \
  -var-file ../nsg.tfvars\
  -var-file ../public-ip-addresses.tfvars \
  -var-file ../routes.tfvars \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve

