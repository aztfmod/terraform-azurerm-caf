data "azurecaf_name" "pvtdnsrie" {
  name          = var.settings.name
  resource_type = "azurerm_private_dns_resolver_inbound_endpoint"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver_inbound_endpoint" "pvt_dns_resolver_inbound_endpoint" {
  name                    = data.azurecaf_name.pvtdnsrie.result
  private_dns_resolver_id = var.private_dns_resolver_id
  location                = var.location
  tags                    = merge(local.tags, try(var.settings.tags, null))
  dynamic "ip_configurations" {
    for_each = toset(var.subnet_ids)
    content {
      private_ip_allocation_method = "Dynamic"
      subnet_id                    = ip_configurations.key
    }
  }

  lifecycle {
    ignore_changes = [name]
  }
}
