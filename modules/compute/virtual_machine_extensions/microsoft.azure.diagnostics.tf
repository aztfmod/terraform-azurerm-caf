
# resource "azurerm_virtual_machine_extension" "microsoft_azure_diagnostics" {
#   for_each = {
#     for key, value in var.extensions : key => value
#     if key == "microsoft_azure_diagnostics"
#   }

#   name = "microsoft_azure_diagnostics"

#   virtual_machine_id   = var.virtual_machine_id
#   publisher            = "Microsoft.Azure.Diagnostics"
#   type                 = "IaaSDiagnostics"
#   type_handler_version = "1.9"

#   settings = jsonencode(
#     {
#       "WadCfg" : each.value.version,
#       "storageAccount" : concat(local.devops_selfhosted_agent.file_uris, local.devops_selfhosted_agent.storage_account_blobs_urls),
#       "LocalResourceDirectory" : 
#     }
#   )
#   protected_settings = jsonencode(
#     {
#       "storageAccountName" : format("bash %s '%s' '%s' '%s' '%s' '%s' '%s' '%s'", var.extensions[each.key].agent_init_script, var.settings[each.key].azure_devops.url, var.settings[each.key].agent_pat, var.settings[each.key].azure_devops.agent_pool.name, var.settings[each.key].azure_devops.agent_pool.agent_name_prefix, var.settings[each.key].azure_devops.agent_pool.num_agents, var.settings[each.key].admin_username, var.settings[each.key].azure_devops.rover_version)
#       "storageAccountKey" :
#       "storageAccountEndPoint" :
#     }
#   )

# }

# locals {
#   microsoft_azure_diagnostics = {
#     file_uris = flatten(
#       [
#         for file_uris_key, file in try(var.extensions.devops_selfhosted_agent.fileUris, {}) : [
#           for file_uri_key in file.storage_blob_keys : var.settings.devops_selfhosted_agent.storage_accounts[file.storage_account_key].containers[file.container_key].blobs[file_uri_key].url
#         ]
#       ]
#     )

#     storage_account_blobs_urls = try(var.settings.devops_selfhosted_agent.storage_account_blobs_urls, [])
#   }
# }
