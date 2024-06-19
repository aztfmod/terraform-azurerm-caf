
data "azurerm_key_vault_secret" "custom_data" {
  for_each = local.os_type == "linux" ? try({ for k, v in local.dynamic_custom_data_to_process["keyvaults"] : k => v }, {}) : {}

  key_vault_id = var.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.keyvault_key].id
  name         = each.value.name
  version      = try(each.value.version, null)
}

data "azurerm_key_vault_key" "custom_data" {
  for_each = local.os_type == "linux" ? try({ for k, v in local.dynamic_custom_data_to_process["keyvault_keys"] : k => v }, {}) : {}

  key_vault_id = var.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.keyvault_key].id
  name         = each.value.name

  depends_on = [azurerm_managed_disk.disk]
}

data "azurerm_key_vault_certificate" "custom_data" {
  for_each = local.os_type == "linux" ? try({ for k, v in local.dynamic_custom_data_to_process["keyvault_certificates"] : k => v }, {}) : {}

  key_vault_id = var.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.keyvault_key].id
  name         = each.value.name
  version      = try(each.value.version, null)
}

locals {

  palo_alto_connection_string = {
    for item in var.settings.virtual_machine_settings :
    item.name => base64encode("storage-account=${var.storage_accounts[var.client_config.landingzone_key][item.palo_alto_connection_string.storage_account].name}, access-key=${var.storage_accounts[var.client_config.landingzone_key][item.palo_alto_connection_string.storage_account].primary_access_key}, file-share=${var.storage_accounts[var.client_config.landingzone_key][item.palo_alto_connection_string.storage_account].file_share[item.palo_alto_connection_string.file_share].name}, share-directory=${var.storage_accounts[var.client_config.landingzone_key][item.palo_alto_connection_string.storage_account].file_share[item.palo_alto_connection_string.file_share].file_share_directories[item.palo_alto_connection_string.file_share_directory].name}")
    if try(item.palo_alto_connection_string, null) != null
  }

  combined_objects = {
    storage_accounts      = var.storage_accounts
    keyvaults             = var.keyvaults
    keyvault_keys         = try(data.azurerm_key_vault_key.custom_data, {})
    keyvault_secrets      = try(data.azurerm_key_vault_secret.custom_data, {})
    keyvault_certificates = try(data.azurerm_key_vault_certificate.custom_data, {})
    vnets                 = var.vnets
  }

  dynamic_custom_data_to_process = {
    for setting in
    flatten([
      for key, value in var.settings.virtual_machine_settings : [
        for k, v in value.dynamic_custom_data : [
          {
            key : k
            value : v
          }
        ]
      ] if can(value.dynamic_custom_data)
    ]) : setting.key => setting.value
  }

  dynamic_custom_data_combined_objects = {
    for key, value in local.dynamic_custom_data_to_process : key =>
    {
      for k, v in value : k => try(local.combined_objects[key][try(v.lz_key, var.client_config.landingzone_key)][k], local.combined_objects[key][k])
    }
  }

  dynamic_custom_data = merge(local.palo_alto_connection_string, local.dynamic_custom_data_combined_objects)
}
