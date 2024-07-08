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
  client_config               = local.client_config
  virtual_machine_id         = module.virtual_machines[each.key].id
  virtual_machine_name       = module.virtual_machines[each.key].name
  recovery_vaults            = local.combined_objects_recovery_vaults
  resource_groups            = local.combined_objects_resource_groups
  storage_accounts           = local.combined_objects_storage_accounts
  disk_encryption_sets       = local.combined_objects_disk_encryption_sets
  settings                   = each.value
  vnets                      = local.combined_objects_networking  
  virtual_machine_os_disk    = module.virtual_machines[each.key].os_disk
  virtual_machine_data_disks = try(module.virtual_machines[each.key].data_disks, null)
  virtual_machine_nics       = module.virtual_machines[each.key].nics 
}

output "vm_replication" {
  value = module.vm_replication
}

module "recovery_plans" {
  source   = "./modules/recovery_vault/recovery_plan"
  for_each = var.recovery_plans
  depends_on = [
    module.vm_replication,
  ]

  global_settings               = local.global_settings
  client_config                 = local.client_config
  settings                      = each.value  
  base_tags                     = local.global_settings.inherit_tags  
  virtual_machines_replication  = local.combined_objects_virtual_machines_replication                    
  recovery_vault_id             = module.recovery_vaults[each.value.recovery_vault_key].id
  recovery_fabrics              = module.recovery_vaults[each.value.recovery_vault_key].recovery_fabrics
}

output "recovery_plans" {
  value = module.recovery_plans
}
