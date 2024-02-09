# resource "azurecaf_name" "egst" {
#   name          = var.settings.name
#   resource_type = "azurerm_eventgrid_system_topic"
#   prefixes      = var.global_settings.prefixes
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }
resource "azurerm_eventgrid_system_topic" "egst" {
  name                   = var.settings.name
  location               = "Global"
  resource_group_name    = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_group[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name
  source_arm_resource_id = can(var.settings.source.id) ? var.settings.communication_services.id : var.remote_objects.communication_services[try(var.settings.communication_services.lz_key, var.client_config.landingzone_key)][var.settings.communication_services.key].id : null
  tags                   = local.tags
  topic_type             = var.settings.topic_type
}
