data "azurecaf_name" "pvtdnsrvnl" {
  for_each      = var.settings.virtual_network_links
  name          = each.value.name
  resource_type = "azurerm_private_dns_resolver_virtual_network_link"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver_virtual_network_link" "pvt_dns_resolver_virtual_network_link" {
  for_each                  = var.settings.virtual_network_links
  name                      = data.azurecaf_name.pvtdnsrvnl[each.key].result
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  virtual_network_id        = can(each.value.id) ? each.value.id : var.virtual_networks[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].id
  metadata                  = can(var.settings.metadata) ? var.settings.metadata : {}

  lifecycle {
    ignore_changes = [name]
  }

}
