module "network_interface_backend_address_pool_association" {
  source   = "./modules/networking/network_interface_backend_address_pool_association"
  for_each = local.networking.network_interface_backend_address_pool_association

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  backend_address_pool_id = can(each.value.backend_address_pool.id) ? each.value.backend_address_pool.id : local.combined_objects_lb_backend_address_pool[try(each.value.backend_address_pool.lz_key, local.client_config.landingzone_key)][each.value.backend_address_pool.key].id
  ip_configuration_name   = can(each.value.ip_configuration_name) ? each.value.ip_configuration_name : local.combined_objects_virtual_machines[try(each.value.network_interface.lz_key, local.client_config.landingzone_key)][each.value.network_interface.vm_key].nics[each.value.network_interface.nic_key].name
  network_interface_id    = can(each.value.network_interface.id) ? each.value.network_interface.id : local.combined_objects_virtual_machines[try(each.value.network_interface.lz_key, local.client_config.landingzone_key)][each.value.network_interface.vm_key].nics[each.value.network_interface.nic_key].id

  remote_objects = {

  }
}

output "network_interface_backend_address_pool_association" {
  value = module.network_interface_backend_address_pool_association
}