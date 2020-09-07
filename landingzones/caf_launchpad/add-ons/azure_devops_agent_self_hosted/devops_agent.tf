

resource "azurerm_storage_container" "deployment" {
  for_each = {
    for key, value in var.virtual_machine_extension_scripts : key => value
    if try(value.storage.container, null) != null
  }

  name                  = each.value.name
  storage_account_name  = module.caf.diagnostic_storage_accounts[each.value.storage_account_key].name
  container_access_type = try(each.value.container_access_type, "blob")
}

# resource "azurerm_storage_blob" "deployment" {
#   name                   = basename(var.vm_object.agent_init_script)
#   storage_account_name   = azurerm_storage_account.devops.name
#   storage_container_name = azurerm_storage_container.deployment.name
#   type                   = "Block"
#   source                 = var.vm_object.agent_init_script
# }

# # Get PAT token from keyvault
# data "azurerm_key_vault_secret" "agent_pat" {
#   name         = var.azure_devops.pat.secret_key_name
#   key_vault_id = local.keyvaults[var.azure_devops.pat.keyvault_key].id
# }

# resource "azurerm_virtual_machine_extension" "devops" {
#   name = "install_azure_devops_agent"

#   virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
#   publisher            = "Microsoft.Azure.Extensions"
#   type                 = "CustomScript"
#   type_handler_version = "2.1"

#   #timestamp: use this field only to trigger a re-run of the script by changing value of this field.
#   #           Any integer value is acceptable; it must only be different than the previous value.
#   settings = jsonencode(
#     {
#       "timestamp" : 6
#     }
#   )
#   protected_settings = jsonencode(
#     {
#       "fileUris" : ["${azurerm_storage_blob.deployment.url}"],
#       "commandToExecute" : "bash ${basename(var.vm_object.agent_init_script)} '${var.azure_devops.url}' '${data.azurerm_key_vault_secret.agent_pat.value}' '${var.azure_devops.agent_pool.name}' '${var.azure_devops.agent_pool.agent_name_prefix}' '${var.azure_devops.agent_pool.num_agents}' '${var.vm_object.admin_username}' '${var.rover_version}'"
#     }
#   )

# }