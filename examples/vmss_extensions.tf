module "vmss_extension_microsoft_azure_domainjoin" {
  source     = "../modules/compute/virtual_machine_scale_set_extensions"
  depends_on = [module.example]

  for_each = {
    for key, value in try(var.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.microsoft_azure_domainjoin, null) != null
  }

  client_config                = module.example.client_config
  virtual_machine_scale_set_id = module.example.virtual_machine_scale_sets[each.key].id
  extension                    = each.value.virtual_machine_scale_set_extensions.microsoft_azure_domainjoin
  extension_name               = "microsoft_azure_domainJoin"
  keyvaults                    = tomap({ (var.landingzone.key) = module.example.keyvaults })
}


module "vmss_extension_custom_scriptextension" {
  source     = "../modules/compute/virtual_machine_scale_set_extensions"
  depends_on = [module.example]

  for_each = {
    for key, value in try(var.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.custom_script, null) != null
  }

  client_config                     = module.example.client_config
  virtual_machine_scale_set_id      = module.example.virtual_machine_scale_sets[each.key].id
  extension                         = each.value.virtual_machine_scale_set_extensions.custom_script
  extension_name                    = "custom_script"
  managed_identities                = tomap({ (var.landingzone.key) = module.example.managed_identities })
  storage_accounts                  = tomap({ (var.landingzone.key) = module.example.storage_accounts })
  virtual_machine_scale_set_os_type = module.example.virtual_machine_scale_sets[each.key].os_type
}


module "vmss_extension_custom_script_data_factory_self_hosted_runtime" {
  source     = "../modules/compute/virtual_machine_scale_set_extensions"
  depends_on = [module.example]

  for_each = {
    for key, value in try(var.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.data_factory_self_hosted_integration_runtime, null) != null
  }

  client_config                     = module.example.client_config
  virtual_machine_scale_set_id      = module.example.virtual_machine_scale_sets[each.key].id
  extension                         = each.value.virtual_machine_scale_set_extensions.data_factory_self_hosted_integration_runtime
  extension_name                    = "data_factory_self_hosted_integration_runtime"
  managed_identities                = tomap({ (var.landingzone.key) = module.example.managed_identities })
  storage_accounts                  = tomap({ (var.landingzone.key) = module.example.storage_accounts })
  virtual_machine_scale_set_os_type = module.example.virtual_machine_scale_sets[each.key].os_type
  keyvaults                         = tomap({ (var.landingzone.key) = module.example.keyvaults })
  keyvault_id                       = module.example.keyvaults["kv1"].id
}
