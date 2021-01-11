#!/bin/bash

set -e

current_folder=$(pwd)
cd standalone

terraform init

terraform apply \
  -var-file ../configuration.tfvars \
  -var-file ../diagnostic_storage_accounts.tfvars \
  -var-file ../diagnostics_definition.tfvars \
  -var-file ../diagnostics_destinations.tfvars\
  -var-file ../dns_zone.tfvars \
  -var-file ../front_door_waf_policies.tfvars \
  -var-file ../front_doors.tfvars \
  -var-file ../keyvault_certificate_requests.tfvars \
  -var-file ../keyvault.tfvars \
  -var tags='{testing_job_id="${1}"}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve


terraform destroy \
  -var-file ../configuration.tfvars \
  -var-file ../diagnostic_storage_accounts.tfvars \
  -var-file ../diagnostics_definition.tfvars \
  -var-file ../diagnostics_destinations.tfvars\
  -var-file ../dns_zone.tfvars \
  -var-file ../front_door_waf_policies.tfvars \
  -var-file ../front_doors.tfvars \
  -var-file ../keyvault_certificate_requests.tfvars \
  -var-file ../keyvault.tfvars \
  -var tags='{testing_job_id="${1}"}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve

