data "azurerm_storage_account" "diag" {
  count = var.boot_diagnostics_storage_account == {} ? 0 : 1
  name                = var.boot_diagnostics_storage_account.name
  resource_group_name = var.boot_diagnostics_storage_account.resource_group_name
}