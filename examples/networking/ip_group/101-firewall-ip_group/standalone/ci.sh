#!/bin/bash

set -e

current_folder=$(pwd)
cd standalone

terraform init

parameter_files=$(find .. | grep .tfvars | sed 's/.*/-var-file &/' | xargs)
echo $parameter_files

eval terraform apply ${parameter_files} \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve

eval terraform destroy ${parameter_files} \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve
