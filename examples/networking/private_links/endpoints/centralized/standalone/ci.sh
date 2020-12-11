#!/bin/bash

current_folder=$(pwd)
cd standalone

terraform init

terraform apply \
  -var-file ../configuration.tfvars \
  -var-file ./private_endpoints.tfvars \
  -var-file ../diagnostic_storage_accounts.tfvars \
  -var-file ../diagnostic_event_hub_namespaces.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../eventhub_namespaces.tfvars \
  -var-file ../virtual_networks.tfvars \
  -var-file ../private_dns.tfvars \
  -var-file ../storage_accounts.tfvars \
  -var tags='{testing_job_id="${1}"}' \
  -input=false \
  -auto-approve


terraform destroy \
  -var-file ../configuration.tfvars \
  -var-file ./private_endpoints.tfvars \
  -var-file ../diagnostic_storage_accounts.tfvars \
  -var-file ../diagnostic_event_hub_namespaces.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../eventhub_namespaces.tfvars \
  -var-file ../virtual_networks.tfvars \
  -var-file ../private_dns.tfvars \
  -var-file ../storage_accounts.tfvars \
  -var tags='{testing_job_id="${1}"}' \
  -input=false \
  -auto-approve
