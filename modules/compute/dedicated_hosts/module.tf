## Need to implement naming convention --> check with provider status

resource "azurerm_dedicated_host" "dh" {
  name                    = var.settings.name
  dedicated_host_group_id = var.dedicated_host_group_id
  location                = var.location
  sku_name                = var.settings.sku_name
  platform_fault_domain   = var.settings.platform_fault_domain
  auto_replace_on_failure = try(var.settings.auto_replace_on_failure, true)
  license_type            = try(var.settings.license_type, "None")
  tags                    = local.tags
}