#
# Bastion host service
# https://www.terraform.io/docs/providers/azurerm/r/bastion_host.html
#

resource "azurecaf_name" "host" {
  for_each = local.enable.bastion_hosts ? local.compute.bastion_hosts : {}

  name          = try(each.value.name, "")
  resource_type = "azurerm_bastion_host"
  prefixes      = [local.global_settings.prefix]
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

resource "azurerm_bastion_host" "host" {
  for_each = local.enable.bastion_hosts ? local.compute.bastion_hosts : {}

  name                = azurecaf_name.host[each.key].result
  location            = module.resource_groups[each.value.resource_group_key].location
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  tags                = try(local.global_settings.inherit_tags, false) ? merge(module.resource_groups[each.value.resource_group_key].tags, try(each.value.tags, null)) : try(each.value.tags, null)

  ip_configuration {
    name                 = each.value.name
    subnet_id            = try(each.value.vnet.lz_key, null) == null ? try(local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet.vnet_key].subnets[each.value.vnet.subnet_key].id, local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id) : local.combined_objects_networking[each.value.vnet.lz_key][each.value.vnet.vnet_key].subnets[each.value.vnet.subnet_key].id
    public_ip_address_id = try(each.value.public_ip.lz_key, null) == null ? try(local.combined_objects_public_ip_addresses[local.client_config.landingzone_key][each.value.public_ip.public_ip_key].id, local.combined_objects_public_ip_addresses[local.client_config.landingzone_key][each.value.public_ip_key].id) : local.combined_objects_public_ip_addresses[each.value.public_ip.lz_key][each.value.public_ip.public_ip_key].id
  }
  timeouts {
    create = "60m"
  }
}

module bastion_host_diagnostics {
  source   = "./modules/diagnostics"
  for_each = local.enable.bastion_hosts ? local.compute.bastion_hosts : {}

  resource_id       = azurerm_bastion_host.host[each.key].id
  resource_location = module.resource_groups[each.value.resource_group_key].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}
