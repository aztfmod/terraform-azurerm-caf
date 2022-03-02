module "vmss_extension_custom_scriptextension" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.custom_script, null) != null
  }

  client_config                     = local.client_config
  virtual_machine_scale_set_id      = module.virtual_machine_scale_sets[each.key].id
  extension                         = each.value.virtual_machine_scale_set_extensions.custom_script
  extension_name                    = "custom_script"
  managed_identities                = local.combined_objects_managed_identities
  storage_accounts                  = local.combined_objects_storage_accounts
  virtual_machine_scale_set_os_type = module.virtual_machine_scale_sets[each.key].os_type
}

module "vmss_extension_microsoft_azure_domainjoin" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.microsoft_azure_domainjoin, null) != null
  }

  client_config                = local.client_config
  virtual_machine_scale_set_id = module.virtual_machine_scale_sets[each.key].id
  extension                    = each.value.virtual_machine_scale_set_extensions.microsoft_azure_domainjoin
  extension_name               = "microsoft_azure_domainJoin"
  keyvaults                    = local.combined_objects_keyvaults
}