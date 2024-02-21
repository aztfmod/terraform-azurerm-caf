resource "azurecaf_name" "egst" {
  name          = var.settings.name
  resource_type = "azurerm_eventgrid_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_eventgrid_system_topic" "egst" {
  name                = azurecaf_name.egst.result
  resource_group_name = coalesce(try(var.settings.resource_group.name, null), try(var.remote_objects.all.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name, null),  try(var.remote_objects.all[var.settings.topic.resource_type][try(var.settings.topic.lz_key, var.client_config.landingzone_key)][var.settings.topic.resource_key].resource_group_name, null))
  location            = coalesce(try(var.settings.location, null), try(var.remote_objects.all.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][try(var.settings.resource_group.key, var.settings.resource_group_key)].location, null), try(var.remote_objects.all[var.settings.topic.resource_type][try(var.settings.topic.lz_key, var.client_config.landingzone_key)][var.settings.topic.resource_key].location, null), "global")

  dynamic "identity" {
      for_each = can(var.settings.identity) ? [var.settings.identity] : []

      content {
        type         = try(identity.value.type, null)
        identity_ids = try(local.managed_identities, null)
      }
    }

  source_arm_resource_id = coalesce(try(var.settings.topic_arm_id, null), try(var.remote_objects.all[var.settings.topic.resource_type][try(var.settings.topic.lz_key, var.client_config.landingzone_key)][var.settings.topic.resource_key].id, null))
  topic_type = var.settings.topic_type
  tags = local.tags

}