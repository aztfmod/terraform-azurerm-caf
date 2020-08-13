provider azurerm {
  features {}
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

data azurerm_client_config current {}

module aad_apps {
  source = "../.."

  aad_apps            = local.aad_apps
  aad_api_permissions = local.aad_api_permissions
  prefix              = local.prefix
  keyvaults           = azurerm_key_vault.keyvault
}

resource "azurecaf_naming_convention" "rg_test" {
  name          = local.resource_groups.test.name
  prefix        = local.prefix != "" ? local.prefix : null
  postfix       = local.postfix != "" ? local.postfix : null
  max_length    = local.max_length != "" ? local.max_length : null
  resource_type = "azurerm_resource_group"
  convention    = local.convention
}

resource "azurerm_resource_group" "rg_test" {
  name     = azurecaf_naming_convention.rg_test.result
  location = local.resource_groups.test.location
  tags     = local.tags
}

resource "azurecaf_naming_convention" "keyvault" {
  for_each = local.keyvaults

  name          = each.value.name
  resource_type = "kv"
  convention    = each.value.convention
  prefix        = local.prefix
}

resource "azurerm_key_vault" "keyvault" {
  for_each = {
    for key, keyvault in local.keyvaults : key => keyvault
  }

  name                = azurecaf_naming_convention.keyvault[each.key].result
  location            = azurerm_resource_group.rg_test.location
  resource_group_name = azurerm_resource_group.rg_test.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = each.value.sku_name

  tags = {
    tfstate     = "level0"
    workspace   = "level0" # Kept for compatibility with 2005.1510
    environment = "Sandpit"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = []
    secret_permissions = ["Get", "List", "Set", "Delete"]
  }

  lifecycle {
    ignore_changes = [
      access_policy
    ]
  }

}

