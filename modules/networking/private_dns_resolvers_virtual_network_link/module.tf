resource "azurecaf_name" "pvtdnsrvnl" {
  name          = var.settings.name
  resource_type = "azurerm_private_dns_resolver_virtual_network_link"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver_virtual_network_link" "pvt_dns_resolver_virtual_network_link" {
  name                      = azurecaf_name.pvtdnsrvnl.result
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  # location                  = var.location
  #tags                      = merge(local.tags, try(var.settings.tags, null))
  virtual_network_id        = var.virtual_network_id

}

