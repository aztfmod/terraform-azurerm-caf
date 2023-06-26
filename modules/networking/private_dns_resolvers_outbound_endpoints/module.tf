data "azurecaf_name" "pvtdnsroe" {
  name          = var.settings.name
  resource_type = "azurerm_private_dns_resolver_outbound_endpoint"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver_outbound_endpoint" "pvt_dns_resolver_outbound_endpoint" {
  name                    = data.azurecaf_name.pvtdnsroe.result
  private_dns_resolver_id = var.private_dns_resolver_id
  location                = local.location
  tags                    = merge(local.tags, try(var.settings.tags, null))
  subnet_id               = var.subnet_id

  lifecycle {
    ignore_changes = [name]
  }

}

