data "azurecaf_name" "pvtdnsrfr" {
  name          = var.settings.name
  resource_type = "azurerm_private_dns_resolver_forwarding_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver_forwarding_rule" "pvt_dns_resolver_forwarding_rule" {
  name                      = data.azurecaf_name.pvtdnsrfr.result
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  domain_name               = var.settings.domain_name
  enabled                   = try(var.settings.enabled, null)
  metadata                  = try(var.settings.metadata, {})

  dynamic "target_dns_servers" {
    for_each = var.settings.target_dns_servers
    content {
      ip_address = target_dns_servers.value.ip_address
      port       = try(target_dns_servers.value.port, 53)
    }
  }


}

