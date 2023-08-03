data "azurecaf_name" "pvtdnsr" {
  name          = var.settings.name
  resource_type = "azurerm_private_dns_resolver"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver" "pvt_dns_resolver" {
  name                = data.azurecaf_name.pvtdnsr.result
  resource_group_name = local.resource_group_name
  virtual_network_id  = var.virtual_network_id
  location            = local.location
  tags                = merge(local.tags, try(var.settings.tags, null))

  lifecycle {
    ignore_changes = [name]
  }
}