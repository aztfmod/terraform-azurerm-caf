# naming convention
resource "azurecaf_name" "ws" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_machine_learning_workspace"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Tested with :  AzureRM version 2.57.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace

resource "azurerm_machine_learning_workspace" "ws" {
  name                    = azurecaf_name.ws.result
  location                = local.resource_group.location
  resource_group_name     = local.resource_group.name
  application_insights_id = var.application_insights_id
  key_vault_id            = var.keyvault_id
  storage_account_id      = var.storage_account_id
  container_registry_id   = var.container_registry_id
  tags                    = try(local.tags, null)
  sku_name                = try(var.settings.sku_name, null)
  description             = try(var.settings.description, null)
  friendly_name           = try(var.settings.friendly_name, null)
  high_business_impact    = try(var.settings.high_business_impact, null)

  identity {
    #Hardcoded as the only supported value is SystemAssigned as per azurerm 2.40
    type = "SystemAssigned"
  }
}


