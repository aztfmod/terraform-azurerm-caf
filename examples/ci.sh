#!/bin/bash

set -e

if [ "$(az account show --query 'user.type' -o tsv)"  == "servicePrincipal" ]; then
  echo "Set security context for Service Principal..."
  export ARM_CLIENT_ID=$(az account show --sdk-auth --only-show-errors | jq -r .clientId)
  export ARM_CLIENT_SECRET=$(az account show --sdk-auth --only-show-errors | jq -r .clientSecret)
  export ARM_SUBSCRIPTION_ID=$(az account show --sdk-auth --only-show-errors | jq -r .subscriptionId)
  export ARM_TENANT_ID=$(az account show --sdk-auth --only-show-errors | jq -r .tenantId)
fi

current_folder=$(pwd)
parameter_files=$(find ${current_folder} | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

cd ${2}

terraform init -upgrade | grep -P '^- (?=Downloading|Using|Finding|Installing)|^[^-]'

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

