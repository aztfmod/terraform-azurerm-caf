#!/bin/bash

set -e

# Refresh the access token to get access to the newly created subscription

user_type=$(az account show --query user.type -o tsv)
tenant_id=$(az account show --query tenantId -o tsv)
subscription_id=$(az account show --query id -o tsv)

if [ ${user_type} == "user" ]; then

  az login --tenant ${tenant_id} --use-device-code > /dev/null

else

  user_name=$(az account show --query user.name -o tsv)
  msi=$(az account show | jq -r .user.assignedIdentityInfo)

  case "${user_name}" in
    "systemAssignedIdentity")
      az login --identity
      ;;
    "userAssignedIdentity")
      msi=$(az account show --query user.assignedIdentityInfo -o tsv)
      msi_id=$(az identity show --ids ${msi//MSIResource-} --query id -o tsv)
      az login --identity -u ${msi_id}
      ;;
    *)
      # When executed from the rover, the context is set automatically. When executed from pipeline, make sure to export the variables before running the terraform deployment.
      # export ARM_CLIENT_ID="value"
      if [ -z "${ARM_CLIENT_ID}" ] || [ -z "${ARM_CLIENT_SECRET}" ] || [ -z "${ARM_TENANT_ID}" ]; then
        echo "Subscription creation with Azure AD Application service principal requires ARM_CLIENT_ID, ARM_CLIENT_SECRET and ARM_TENANT_ID to be set in the bash context."
        exit 3000
      else
        az login --service-principal -u "${ARM_CLIENT_ID}" -p "${ARM_CLIENT_SECRET}" -t "${ARM_TENANT_ID}"
      fi
      ;;
  esac

fi

az account set -s ${subscription_id}
