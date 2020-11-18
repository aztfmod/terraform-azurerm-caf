
terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}


data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  number  = false
}

resource "random_string" "alpha1" {
  length  = 1
  special = false
  upper   = false
  number  = false
}

# The rover handle the identity management transition to cover interactive run and execution on pipelines using azure ad applications or managed identities
# There are different scenrios are considered:
#
# 1 - running launchpad from vscode
#  In this bootstrap scenario the launchpad is executed under a logged in user azure session. The rover sets the logged_user_objectId through environment variable. During that initial run an Azure AD application (refered as launchpad_app_level0) is created to support any execution from a pipeline.
# 2 - deploying a landing zone or a solution from vscode
#  Step 1 has been executed. The rover is still connect to a logged in user azure session. The rover use the user's credentials to connect the default azure subscription to identity the storage account and the keyvault holding the tfstate and the launchpad_app_level0 credentials. The rover set the terraform ARM_* variables to change the terraform provider Azure context (client id, secret, tenant and subscription). The logged_aad_app_objectId is set to the launchpad_app_level0's client_id. Note in that scenario the azure session does not change. Meaning when terraform execute some local execution scripts they are executed in the context of the logged_in_user and not the azure ad application. To simulate from vscode the execution of a local exec with the launchpad_app_level0 credentials, the rover must be executed with the parameter --impersonate (cannot be used during the launchpad initial deployment and destruciton)


data "azuread_service_principal" "logged_in_app" {
  count          = try(data.azurerm_client_config.current.object_id, null) == null ? 1 : 0
  application_id = data.azurerm_client_config.current.client_id
}