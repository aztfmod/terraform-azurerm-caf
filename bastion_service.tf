#
# Bastion host service
# https://www.terraform.io/docs/providers/azurerm/r/bastion_host.html
#

resource "azurecaf_name" "host" {
  for_each = try(local.compute.bastion_hosts, {})

  name          = try(each.value.name, "")
  resource_type = "azurerm_bastion_host"
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

# Last updated with :  AzureRM version 2.64.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host

resource "azurerm_bastion_host" "host" {
  for_each = try(local.compute.bastion_hosts, {})

  name = azurecaf_name.host[each.key].result
  tags = try(local.global_settings.inherit_tags, false) ? merge(local.resource_groups[each.value.resource_group_key].tags, try(each.value.tags, null)) : try(each.value.tags, null)

  location = lookup(each.value, "region", null) != null ? local.global_settings.regions[each.value.region] : coalesce(
    try(local.resource_groups[each.value.resource_group_key].location, null), #Kept for backwards compatibility
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].location, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].location, null)
  )

  resource_group_name = coalesce(
    try(local.resource_groups[each.value.resource_group_key].name, null), #Kept for backwards compatibility
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null)
  )

  ip_configuration {
    name      = each.value.name
    subnet_id = local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][try(each.value.vnet.vnet_key, each.value.vnet_key)].subnets[try(each.value.vnet.subnet_key, each.value.subnet_key)].id
    public_ip_address_id = coalesce(
      try(local.combined_objects_public_ip_addresses[each.value.public_ip.lz_key][each.value.public_ip.key].id, null),
      try(local.combined_objects_public_ip_addresses[each.value.public_ip.lz_key][each.value.public_ip.public_ip_key].id, null),
      try(local.combined_objects_public_ip_addresses[each.value.public_ip.lz_key][each.value.public_ip_key].id, null),
      try(local.combined_objects_public_ip_addresses[local.client_config.landingzone_key][each.value.public_ip.key].id, null),
      try(local.combined_objects_public_ip_addresses[local.client_config.landingzone_key][each.value.public_ip.public_ip_key].id, null),
      try(local.combined_objects_public_ip_addresses[local.client_config.landingzone_key][each.value.public_ip_key].id, null),
      try(each.value.public_ip.id, null)
    )
  }
  timeouts {
    create = "60m"
  }
  lifecycle {
    ignore_changes = [
      ip_configuration[0].public_ip_address_id
    ]
  }
}

module "bastion_host_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = try(local.compute.bastion_hosts, {})

  resource_id = azurerm_bastion_host.host[each.key].id
  diagnostics = local.combined_diagnostics
  profiles    = try(each.value.diagnostic_profiles, {})

  resource_location = lookup(each.value, "region", null) != null ? local.global_settings.regions[each.value.region] : coalesce(
    try(local.resource_groups[each.value.resource_group_key].location, null), #Kept for backwards compatibility
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].location, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].location, null)
  )
}
