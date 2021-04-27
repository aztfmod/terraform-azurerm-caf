#
# microsoft_enterprise_cloud_monitoring - Install the monitoring agent in the virtual machine
#

module "vm_extension_monitoring_agent" {
  source     = "../../modules/compute/virtual_machine_extensions"
  depends_on = [module.example]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring, null) != null
  }

  client_config      = module.example.client_config
  virtual_machine_id = module.example.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring
  extension_name     = "microsoft_enterprise_cloud_monitoring"
  settings = {
    diagnostics = module.example.diagnostics
  }
}

module "vm_extension_diagnostics" {
  source     = "../../modules/compute/virtual_machine_extensions"
  depends_on = [module.example]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_diagnostics, null) != null
  }

  client_config      = module.example.client_config
  virtual_machine_id = module.example.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_azure_diagnostics
  extension_name     = "microsoft_azure_diagnostics"
  settings = {
    var_folder_path                  = var.var_folder_path
    diagnostics                      = module.example.diagnostics
    xml_diagnostics_file             = try(each.value.virtual_machine_extensions.microsoft_azure_diagnostics.xml_diagnostics_file, null)
    diagnostics_storage_account_keys = each.value.virtual_machine_extensions.microsoft_azure_diagnostics.diagnostics_storage_account_keys
  }
}

module "additional_session_host_dscextension" {
  source     = "../modules/compute/virtual_machine_extensions"
  depends_on = [module.caf, module.microsoft_azure_domainJoin]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.additional_session_host_dscextension, null) != null
  }

  client_config      = module.caf.client_config
  virtual_machine_id = module.caf.virtual_machines[each.key].id
  keyvault_id        = local.combined.keyvaults[try(each.value.virtual_machine_extensions.additional_session_host_dscextension.lz_key, module.caf.client_config.landingzone_key)][each.value.virtual_machine_extensions.additional_session_host_dscextension.keyvault_key].id
  extension          = each.value.virtual_machine_extensions.additional_session_host_dscextension
  extension_name     = "additional_session_host_dscextension"
  settings = {
    diagnostics = module.caf.diagnostics

  }
}

module "microsoft_azure_domainJoin" {
  source     = "../modules/compute/virtual_machine_extensions"
  depends_on = [module.caf]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_domainJoin, null) != null
  }

  client_config      = module.caf.client_config
  virtual_machine_id = module.caf.virtual_machines[each.key].id
  keyvault_id        = local.combined.keyvaults[try(each.value.virtual_machine_extensions.microsoft_azure_domainJoin.lz_key, module.caf.client_config.landingzone_key)][each.value.virtual_machine_extensions.microsoft_azure_domainJoin.keyvault_key].id
  extension          = each.value.virtual_machine_extensions.microsoft_azure_domainJoin
  extension_name     = "microsoft_azure_domainJoin"
  settings = {
    diagnostics = module.caf.diagnostics
  }
}


# module "custom_script_extensions" {
#   source     = "../modules/compute/virtual_machine_extensions"
#   depends_on = [module.caf]

#   for_each = {
#     for key, value in try(var.virtual_machines, {}) : key => value
#     if try(value.virtual_machine_extensions.custom_script_extensions, null) != null
#   }

#   client_config      = module.caf.client_config
#   virtual_machine_id = module.caf.virtual_machines[each.key].id
#   keyvault_id        = local.combined.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][var.keyvault_key].id
#   extension          = each.value.virtual_machine_extensions.custom_script_extensions
#   extension_name     = "custom_script_extensions"
#   settings = {
#     diagnostics = module.caf.diagnostics
#   }
# }



