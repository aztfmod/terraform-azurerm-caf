module "recovery_vault" {
  source   = "../private_endpoint"
  for_each = try(var.private_endpoints.recovery_vaults, {})

  global_settings     = var.global_settings
  client_config       = var.client_config
  settings            = each.value
  resource_id         = coalesce(
    try(var.remote_objects.recovery_vaults[each.value.lz_key][each.key].id, null),
    try(var.remote_objects.recovery_vaults[var.client_config.landingzone_key][each.key].id, null),
    try(each.value.resource_id, null)
  )
  subresource_names   = ["AzureSiteRecovery"]
  subnet_id           = var.subnet_id
  private_dns         = var.private_dns
  name                = try(each.value.name, each.key)
  resource_group_name = try(var.resource_groups[each.value.resource_group_key].name, var.vnet_resource_group_name)
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  base_tags           = var.base_tags
}