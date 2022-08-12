#
# microsoft_enterprise_cloud_monitoring - Install the monitoring agent in the virtual machine
#

module "vm_extension_monitoring_agent" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring, null) != null
  }

  client_config      = local.client_config
  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring
  extension_name     = "microsoft_enterprise_cloud_monitoring"
  settings = {
    diagnostics = local.combined_diagnostics
  }
}

module "vm_extension_diagnostics" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_diagnostics, null) != null
  }

  client_config      = local.client_config
  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_azure_diagnostics
  extension_name     = "microsoft_azure_diagnostics"
  settings = {
    var_folder_path                  = var.var_folder_path
    diagnostics                      = local.combined_diagnostics
    xml_diagnostics_file             = try(each.value.virtual_machine_extensions.microsoft_azure_diagnostics.xml_diagnostics_file, null)
    diagnostics_storage_account_keys = each.value.virtual_machine_extensions.microsoft_azure_diagnostics.diagnostics_storage_account_keys
  }
}

module "vm_extension_microsoft_azure_domainjoin" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_domainjoin, null) != null
  }

  client_config      = local.client_config                  #refer landingzone.tf for the correct module name.
  virtual_machine_id = module.virtual_machines[each.key].id #refer landingzone.tf for the correct module name.
  extension          = each.value.virtual_machine_extensions.microsoft_azure_domainjoin
  extension_name     = "microsoft_azure_domainJoin"
  keyvaults          = local.combined_objects_keyvaults
}

module "vm_extension_session_host_dscextension" {
  source     = "./modules/compute/virtual_machine_extensions"
  depends_on = [module.vm_extension_microsoft_azure_domainjoin] #refer landingzone.tf for the correct module name.

  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.session_host_dscextension, null) != null
  }

  client_config      = local.client_config                  #refer landingzone.tf for the correct module name.
  virtual_machine_id = module.virtual_machines[each.key].id #refer landingzone.tf for the correct module name.
  extension          = each.value.virtual_machine_extensions.session_host_dscextension
  extension_name     = "session_host_dscextension"
  keyvaults          = local.combined_objects_keyvaults
  wvd_host_pools     = local.combined_objects_wvd_host_pools
}

module "vm_extension_custom_scriptextension" {
  source = "./modules/compute/virtual_machine_extensions"

  depends_on = [module.vm_extension_microsoft_azure_domainjoin]

  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.custom_script, null) != null
  }

  client_config           = local.client_config
  virtual_machine_id      = module.virtual_machines[each.key].id
  virtual_machine_os_type = module.virtual_machines[each.key].os_type
  extension               = each.value.virtual_machine_extensions.custom_script
  extension_name          = "custom_script"
  managed_identities      = local.combined_objects_managed_identities
  storage_accounts        = local.combined_objects_storage_accounts
}

module "vm_extension_generic" {
  source = "./modules/compute/virtual_machine_extensions"
  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.generic_extensions, null) != null
  }

  client_config           = local.client_config
  virtual_machine_id      = module.virtual_machines[each.key].id
  virtual_machine_os_type = module.virtual_machines[each.key].os_type
  extension               = each.value.virtual_machine_extensions.generic_extensions
  extension_name          = "generic_extension"
}

module "keyvault_for_windows" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.keyvault_for_windows, null) != null
  }

  client_config           = local.client_config
  virtual_machine_id      = module.virtual_machines[each.key].id
  virtual_machine_os_type = module.virtual_machines[each.key].os_type
  managed_identities      = local.combined_objects_managed_identities
  extension               = each.value.virtual_machine_extensions.keyvault_for_windows
  extension_name          = "keyvault_for_windows"
  keyvaults               = local.combined_objects_keyvaults
}