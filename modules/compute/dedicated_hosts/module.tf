resource "azurecaf_name" "dh" {
  name          = var.settings.name
  resource_type = "azurerm_dedicated_host"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.63.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dedicated_host

resource "azurerm_dedicated_host" "dh" {
  name                    = azurecaf_name.dh.result
  dedicated_host_group_id = var.dedicated_host_group_id
  location                = var.location
  sku_name                = var.settings.sku_name
  platform_fault_domain   = var.settings.platform_fault_domain
  auto_replace_on_failure = try(var.settings.auto_replace_on_failure, true)
  license_type            = try(var.settings.license_type, "None")
  tags                    = local.tags
}