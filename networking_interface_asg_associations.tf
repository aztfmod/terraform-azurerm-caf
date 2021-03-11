module networking_interface_asg_associations {
  source   = "./modules/networking/networking_interface_asg_association"
  for_each = local.networking.networking_interface_asg_associations

  client_config       = local.client_config
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  global_settings     = local.global_settings
  # virtual_machines    = module.virtual_machines
  network_interface_id = module.virtual_machines[each.key].nic_id
  application_security_group_id = module.application_security_groups[each.key].id
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}
