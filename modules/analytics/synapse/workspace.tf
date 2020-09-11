# naming convention
resource "azurecaf_name" "wp" {
  name          = var.settings.name
  resource_type = "azurerm_machine_learning_workspace"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

# synapse workspace
resource "azurerm_synapse_workspace" "wp" {
  name                                 = azurecaf_name.wp.result
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_data_lake_gen2_filesystem_id
  sql_administrator_login              = "sqladminuser"
  sql_administrator_login_password     = "H@Sh1CoR3!"
  tags                                 = try(var.settings.tags, null)
}