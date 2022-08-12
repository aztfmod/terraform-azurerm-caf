#Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ip_group

resource "azurecaf_name" "ip_group" {
  name          = var.name
  resource_type = "azurerm_ip_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

locals {
  cidrs = try(var.settings.cidrs, try(var.settings.subnet_keys, []) == [] ? var.vnet.address_space : flatten([
    for key, subnet in var.vnet.subnets : subnet.cidr
    if contains(var.settings.subnet_keys, key)
  ]))
}
output "cidrs" {
  value = local.cidrs
}
resource "azurerm_ip_group" "ip_group" {

  name                = azurecaf_name.ip_group.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  cidrs               = local.cidrs
}


#   subnets             = lookup(each.value, "lz_key", null) == null ? local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets : local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].subnets
