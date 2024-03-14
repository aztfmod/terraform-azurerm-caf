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
  source     = "./modules/compute/virtual_machine_extensions"
  depends_on = [module.keyvault_certificates]

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

module "vm_extension_linux_diagnostic" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.linux_diagnostic, null) != null
  }

  client_config      = local.client_config
  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.linux_diagnostic
  extension_name     = "linux_diagnostic"

  settings = {
    var_folder_path            = var.var_folder_path
    diagnostics                = local.combined_diagnostics
    diagnostic_storage_account = local.combined_objects_diagnostic_storage_accounts[try(each.value.storage_account.lz_key, local.client_config.landingzone_key)][each.value.virtual_machine_extensions.linux_diagnostic.diagnostic_storage_account_key]
  }
}

module "vm_extensions_devops_selfhosted_agent" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in local.compute.virtual_machines : key => value
    if can(value.virtual_machine_extensions.devops_selfhosted_agent)
  }

  client_config      = local.client_config
  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.devops_selfhosted_agent
  extension_name     = "devops_selfhosted_agent"

  settings = {
    devops_selfhosted_agent = {
      var_folder_path  = var.var_folder_path
      storage_accounts = module.storage_accounts
      admin_username   = each.value.virtual_machine_settings[each.value.os_type].admin_username
      storage_account_blobs_urls = can(each.value.virtual_machine_extensions.devops_selfhosted_agent.storage_account_blobs) ? [
        for key in try(each.value.virtual_machine_extensions.devops_selfhosted_agent.storage_account_blobs, []) : module.storage_account_blobs[key].url
      ] : each.value.virtual_machine_extensions.devops_selfhosted_agent.storage_account_blobs_urls
      managed_identities = local.combined_objects_managed_identities
      keyvaults          = local.combined_objects_keyvaults
    }
  }
}


module "vm_extensions_tfcloud_selfhosted_agent" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in local.compute.virtual_machines : key => value
    if can(value.virtual_machine_extensions.tfcloud_selfhosted_agent)
  }

  client_config      = local.client_config
  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.tfcloud_selfhosted_agent
  extension_name     = "tfcloud_selfhosted_agent"

  settings = {
    tfcloud_selfhosted_agent = {
      var_folder_path  = var.var_folder_path
      storage_accounts = module.storage_accounts
      admin_username   = each.value.virtual_machine_settings[each.value.os_type].admin_username
      storage_account_blobs_urls = can(each.value.virtual_machine_extensions.tfcloud_selfhosted_agent.storage_account_blobs) ? [
        for key in try(each.value.virtual_machine_extensions.tfcloud_selfhosted_agent.storage_account_blobs, []) : module.storage_account_blobs[key].url
      ] : each.value.virtual_machine_extensions.tfcloud_selfhosted_agent.storage_account_blobs_urls
      managed_identities = local.combined_objects_managed_identities
      keyvaults          = local.combined_objects_keyvaults
    }
  }
}
