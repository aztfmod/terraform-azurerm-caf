# resource "azurecaf_naming_convention" "name" {
#   name   = var.settings.name
#   prefix = var.global_settings.prefix
#   max_length    = var.global_settings.max_length
#   resource_type = "azurerm_synapse_workspace"
#   convention    = var.global_settings.convention
# }


resource "azurerm_synapse_workspace" "wp" {
  name                                 = var.settings.name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_data_lake_gen2_filesystem_id
  sql_administrator_login              = "sqladminuser"
  sql_administrator_login_password     = "H@Sh1CoR3!"
  tags                                 = try(var.settings.tags, null)
}