#!/bin/bash

set -e

current_folder=$(pwd)
parameter_files=$(find ${current_folder} | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

cd ${2}

terraform init

terraform apply \
  ${parameter_files} \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve


terraform destroy \
  ${parameter_files} \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve

