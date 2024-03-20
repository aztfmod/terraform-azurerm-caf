module "vm_replication" {
  source = "./modules/compute/virtual_machine_replication"
  depends_on = [
    module.virtual_machines,
    module.vm_extension_custom_scriptextension,

  ]

  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.replication, null) != null
  }

  virtual_machine_id         = module.virtual_machines[each.key].id
  virtual_machine_name       = module.virtual_machines[each.key].name
  recovery_vaults            = local.combined_objects_recovery_vaults
  resource_groups            = local.combined_objects_resource_groups
  storage_accounts           = local.combined_objects_storage_accounts
  disk_encryption_sets       = local.combined_objects_disk_encryption_sets
  settings                   = each.value
  vnets                      = local.combined_objects_networking
  client_config              = local.client_config
  virtual_machine_os_disk    = module.virtual_machines[each.key].os_disk
  virtual_machine_data_disks = module.virtual_machines[each.key].data_disks
  virtual_machine_nics       = module.virtual_machines[each.key].nics
}
