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
  resource_group_name = local.resource_group_name
  location            = local.location

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [var.settings.identity] : []

    content {
      type         = try(identity.value.type, null)
      identity_ids = try(local.managed_identities, null)
    }
  }

  source_arm_resource_id = coalesce(try(var.settings.topic.resource_id, null), try(var.remote_objects[var.settings.topic.resource_type][try(var.settings.topic.lz_key, var.client_config.landingzone_key)][var.settings.topic.resource_key].id, null))
  topic_type             = var.settings.topic_type
  tags                   = local.tags

}