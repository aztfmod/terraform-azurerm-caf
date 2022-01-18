
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.88.1"
      configuration_aliases = [
        azurerm.vhub
      ]
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.15"
}

provider "azurerm" {
  partner_id = "ca4078f8-9bc4-471b-ab5b-3af6b86a42c8"
  # partner identifier for CAF Terraform landing zones.
  features {
    template_deployment {
      delete_nested_items_during_deletion = false
    }
  }
}


data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

# The rover handle the identity management transition to cover interactive run and execution on pipelines using azure ad applications or managed identities
# There are different scenrios are considered:
#
# 1 - running launchpad from vscode
#  In this bootstrap scenario the launchpad is executed under a logged in user azure session. The rover sets the logged_user_objectId through environment variable. During that initial run an Azure AD application (refered as launchpad_app_level0) is created to support any execution from a pipeline.
# 2 - deploying a landing zone or a solution from vscode
#  Step 1 has been executed. The rover is still connected to a logged in user azure session. The rover use the user's credentials to connect the default azure subscription to identity the storage account and the keyvault holding the tfstate and the launchpad_app_level0 credentials. The rover set the terraform ARM_* variables to change the terraform provider Azure context (client id, secret, tenant and subscription). The logged_aad_app_objectId is set to the launchpad_app_level0's client_id. Note in that scenario the azure session does not change. Meaning when terraform execute some local execution scripts they are executed in the context of the logged_in_user and not the azure ad application. To simulate from vscode the execution of a local exec with the launchpad_app_level0 credentials, the rover must be executed with the parameter --impersonate (cannot be used during the launchpad initial deployment and destruciton)

# If you are runnign the module as standalone, with a service principal:
# Set the security context for Azure Terraform providers:

# session=$(az account show --sdk-auth -o json 2> /dev/null)
# export ARM_CLIENT_ID=$(echo $session | jq -r .clientId)
# export ARM_CLIENT_SECRET=$(echo $session | jq -r .clientSecret)
# export ARM_TENANT_ID=$(echo $session | jq -r .tenantId)
# export ARM_SUBSCRIPTION_ID=$(echo $session | jq -r .subscriptionId)

data "azuread_service_principal" "logged_in_app" {
  count          = var.logged_aad_app_objectId == null ? 0 : 1
  application_id = data.azurerm_client_config.current.client_id
}
