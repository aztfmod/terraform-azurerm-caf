#!/bin/bash

set -e

current_folder=$(pwd)
cd standalone

terraform init

terraform apply \
  -var-file ../configuration.tfvars \
  -var-file  ../diagnostic_event_hub_namespaces.tfvars \
  -var-file  ../diagnostics_definition.tfvars \
  -var-file  ../diagnostics_destinations.tfvars \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve


terraform destroy \
  -var-file ../configuration.tfvars \
  -var-file  ../diagnostic_event_hub_namespaces.tfvars \
  -var-file  ../diagnostics_definition.tfvars \
  -var-file  ../diagnostics_destinations.tfvars \
  -var tags='{testing_job_id='"${1}"'}' \
  -var var_folder_path=${current_folder} \
  -input=false \
  -auto-approve

