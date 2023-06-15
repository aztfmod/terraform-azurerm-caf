data "azurecaf_name" "pvtdnsrfrs" {
  name          = var.settings.name
  resource_type = "azurerm_private_dns_resolver_dns_forwarding_ruleset"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "pvt_dns_resolver_forwarding_ruleset" {
  name                                       = data.azurecaf_name.pvtdnsrfrs.result
  resource_group_name                        = local.resource_group_name
  location                                   = local.location
  tags                                       = merge(local.tags, try(var.settings.tags, null))
  private_dns_resolver_outbound_endpoint_ids = toset(var.outbound_endpoint_ids)

  lifecycle {
    ignore_changes = [name]
  }

}

