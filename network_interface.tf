module "network_interface_backend_address_pool_association" {
  source   = "./modules/networking/network_interface_backend_address_pool_association"
  for_each = local.networking.network_interface_backend_address_pool_association

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  backend_address_pool_id = coalesce(
    try(local.combined_objects_lb_backend_address_pool[each.value.backend_address_pool.lz_key][each.value.backend_address_pool.key].id, null),
    try(local.combined_objects_lb_backend_address_pool[local.client_config.landingzone_key][each.value.backend_address_pool.key].id, null),
    try(each.value.backend_address_pool.id, null)
  )
  ip_configuration_name = coalesce(
    try(local.combined_objects_virtual_machines[each.value.network_interface.lz_key][each.value.network_interface.vm_key].nics[each.value.network_interface.nic_key].name, null),
    try(local.combined_objects_virtual_machines[local.client_config.landingzone_key][each.value.network_interface.vm_key].nics[each.value.network_interface.nic_key].name, null),
    try(each.value.ip_configuration_name, null)
  )
  network_interface_id = coalesce(
    try(local.combined_objects_virtual_machines[each.value.network_interface.lz_key][each.value.network_interface.vm_key].nics[each.value.network_interface.nic_key].id, null),
    try(local.combined_objects_virtual_machines[local.client_config.landingzone_key][each.value.network_interface.vm_key].nics[each.value.network_interface.nic_key].id, null),
    try(each.value.network_interface.id, null)
  )

  remote_objects = {

  }
}
output "network_interface_backend_address_pool_association" {
  value = module.network_interface_backend_address_pool_association
}