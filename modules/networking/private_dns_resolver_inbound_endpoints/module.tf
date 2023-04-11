resource "azurecaf_name" "pvtdnsrie" {
  name          = var.settings.name
  resource_type = "azurerm_private_dns_resolver_inbound_endpoint"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver_inbound_endpoint" "pvt_dns_resolver_inbound_endpoint" {
  name                = azurecaf_name.pvtdnsrie.result
  resource_group_name = var.resource_group.name
  virtual_network_id  = var.virtual_network_id
  location            = var.location
  tags                = merge(local.tags, try(var.settings.tags, null))
}