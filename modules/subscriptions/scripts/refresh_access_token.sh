#!/bin/bash

set -e

# Refresh the access token to get access to the newly created subscription

user_type=$(az account show --query user.type -o tsv)
tenant_id=$(az account show --query tenantId -o tsv)
subscription_id=$(az account show --query id -o tsv)

if [ ${user_type} == "user" ]; then

  az login --tenant ${tenant_id} --use-device-code --allow-no-subscriptions > /dev/null

else

  user_name=$(az account show --query user.name -o tsv)
  msi=$(az account show | jq -r .user.assignedIdentityInfo)

  case "${user_name}" in
    "systemAssignedIdentity")
      az login --identity --allow-no-subscription
      ;;
    "userAssignedIdentity")
      msi=$(az account show --query user.assignedIdentityInfo -o tsv)
      msi_id=$(az identity show --ids ${msi//MSIResource-} --query id -o tsv)
      az login --identity --allow-no-subscription -u ${msi_id}
      ;;
    *)
      echo "Subscription creation with Azure AD Application service principal is not yet supported."
      exit 3000
  esac

fi

az account set -s ${subscription_id}
