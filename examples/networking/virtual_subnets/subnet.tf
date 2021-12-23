module "subnet" {
  source   = "./modules/aaa/subnet"
  for_each = local.aaa.subnet

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

    resource_group_name = coalesce(
        try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
        try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
        try(each.value.resource_group.name, null)
    )

    virtual_network_name = coalesce(
        try(local.combined_objects_virtual_network[each.value.virtual_network.lz_key][each.value.virtual_network.key].name, null),
        try(local.combined_objects_virtual_network[local.client_config.landingzone_key][each.value.virtual_network.key].name, null),
        try(each.value.virtual_network.name, null)
    )


  remote_objects = {
        resource_group = local.combined_objects_resource_groups
        virtual_network = local.combined_objects_virtual_network
  }
}
output "subnet" {
  value = module.subnet
}