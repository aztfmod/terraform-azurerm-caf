resource "azurecaf_name" "sysp" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_synapse_sql_pool"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_sql_pool" "sysp" {
  name                 = azurecaf_name.sysp.result
  synapse_workspace_id = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  sku_name             = var.settings.sku_name
  create_mode          = try(var.settings.create_mode, null)
  collation            = try(var.settings.collation, null)
  data_encrypted       = try(var.settings.data_encrypted, null)
  recovery_database_id = try(var.settings.recovery_database_id, null)
  dynamic "restore" {
    for_each = try(var.settings.restore, null) != null ? [var.settings.restore] : []
    content {
      source_database_id = try(restore.value.source_database_id, null)
      point_in_time      = try(restore.value.point_in_time, null)
    }
  }
  tags = local.tags
}