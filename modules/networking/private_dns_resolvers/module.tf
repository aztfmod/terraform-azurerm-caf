resource "azurecaf_name" "private_dns_resolver" {
  name          = each.value.name
  resource_type = "azurerm_private_dns_resolver"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}


resource "azurerm_private_dns_resolver" "private_dns_resolver" {
  name                  = azurecaf_name.private_dns_resolver.result
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_id
  location              = var.location
  tags                  = merge(var.base_tags, local.module_tag, try(each.value.tags, null))
}


