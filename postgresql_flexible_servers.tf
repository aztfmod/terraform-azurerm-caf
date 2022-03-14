output "postgresql_flexible_servers" {
  value = module.postgresql_flexible_servers
}

module "postgresql_flexible_servers" {
  source     = "./modules/databases/postgresql_flexible_server"
  depends_on = [module.keyvaults, module.networking]
  for_each   = local.database.postgresql_flexible_servers

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key], null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key], null),
    try(each.value.resource_group.name, null)
  )

  remote_objects = {
    subnet_id = try(
      local.combined_objects_networking[each.value.vnet.lz_key][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id,
      local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id,
      null
    )

    private_dns_zone_id = try(
      local.combined_objects_private_dns[each.value.private_dns_zone.lz_key][each.value.private_dns_zone.key].id,
      local.combined_objects_private_dns[local.client_config.landingzone_key][each.value.private_dns_zone.key].id,
      null
    )

    keyvault_id = try(
      local.combined_objects_keyvaults[each.value.keyvault.lz_key][each.value.keyvault.key].id,
      local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault.key].id,
      null
    )

    diagnostics = local.combined_diagnostics
  }

}