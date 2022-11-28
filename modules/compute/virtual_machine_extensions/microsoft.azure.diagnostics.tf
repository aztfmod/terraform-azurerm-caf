
resource "azurerm_virtual_machine_extension" "diagnostics" {
  for_each = var.extension_name == "microsoft_azure_diagnostics" ? toset(["enabled"]) : toset([])

  name = "microsoft_azure_diagnostics"

  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.Diagnostics"
  type                       = "IaaSDiagnostics"
  type_handler_version       = try(var.extension.type_handler_version, "1.9")
  auto_upgrade_minor_version = try(var.extension.auto_upgrade_minor_version, true)

  settings = jsonencode(
    {
      "xmlCfg" : base64encode(templatefile(local.microsoft_azure_diagnostics.template_path, { resource_id = var.virtual_machine_id }))
      "storageAccount" : var.settings.diagnostics.storage_accounts[var.extension.diagnostics_storage_account_keys[0]].name
    }
  )
  protected_settings = jsonencode(
    {
      "storageAccountName" : var.settings.diagnostics.storage_accounts[var.extension.diagnostics_storage_account_keys[0]].name,
      "storageAccountKey" : base64encode(data.external.storage_account_key["enabled"].result.value)
    }
  )

}

# data "azurerm_storage_account" "diagnostics_storage_account" {
#   for_each = var.extension_name == "microsoft_azure_diagnostics" ? toset(try(var.extension.diagnostics_storage_account_keys, [])) : toset([])

#   name                = var.settings.diagnostics.storage_accounts[each.key].name
#   resource_group_name = var.settings.diagnostics.storage_accounts[each.key].resource_group_name
# }

locals {
  microsoft_azure_diagnostics = {
    template_path = var.extension_name == "microsoft_azure_diagnostics" ? fileexists(var.settings.xml_diagnostics_file) ? var.settings.xml_diagnostics_file : format("%s/%s", var.settings.var_folder_path, var.settings.xml_diagnostics_file) : null
  }
}

data "external" "storage_account_key" {
  for_each = var.extension_name == "microsoft_azure_diagnostics" ? toset(["enabled"]) : toset([])
  program = [
    "bash", "-c",
    format(
      "az storage account keys list --account-name '%s' --resource-group '%s' --subscription '%s' --query '[0].{value: value}' -o json",
      var.settings.diagnostics.storage_accounts[var.extension.diagnostics_storage_account_keys[0]].name,
      var.settings.diagnostics.storage_accounts[var.extension.diagnostics_storage_account_keys[0]].resource_group_name,
      substr(var.settings.diagnostics.storage_accounts[var.extension.diagnostics_storage_account_keys[0]].id, 15, 36)
    )
  ]
}