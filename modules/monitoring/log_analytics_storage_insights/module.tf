
resource "azurecaf_name" "lasi" {
  name          = var.settings.name
  resource_type = "azurerm_log_analytics_storage_insights"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_log_analytics_storage_insights" "lasi" {
  name                 = azurecaf_name.lasi.result
  resource_group_name  = var.resource_group_name
  workspace_id         = var.workspace_id
  storage_account_id   = var.storage_account_id
  storage_account_key  = var.primary_access_key
  blob_container_names = try(var.settings.blob_container_names, null)
  table_names          = try(var.settings.table_names, null)
  tags                 = local.tags

}