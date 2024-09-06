resource "azurecaf_name" "egt" {
  name          = var.settings.name
  resource_type = "azurerm_eventgrid_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_eventgrid_system_topic" "egt" {
  name                = azurecaf_name.egt.result
  resource_group_name = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name
  location            = var.location

  source_arm_resource_id = try(
    var.settings.source_resource_id,
    var.remote_objects[var.settings.source_resource.type][try(var.settings.source_resource.lz_key, var.client_config.landingzone_key)][var.settings.source_resource.key].id,
    null
  )

  # topic_type can be one of these, more resource types can be supported
  # Microsoft.AppConfiguration.ConfigurationStores
  # Microsoft.Communication.CommunicationServices
  # Microsoft.ContainerRegistry.Registries
  # Microsoft.Devices.IoTHubs
  # Microsoft.EventGrid.Domains
  # Microsoft.EventGrid.Topics
  # Microsoft.Eventhub.Namespaces
  # Microsoft.KeyVault.vaults
  # Microsoft.MachineLearningServices.Workspaces
  # Microsoft.Maps.Accounts
  # Microsoft.Media.MediaServices
  # Microsoft.Resources.ResourceGroups
  # Microsoft.Resources.Subscriptions
  # Microsoft.ServiceBus.Namespaces
  # Microsoft.SignalRService.SignalR
  # Microsoft.Storage.StorageAccounts
  # Microsoft.Web.ServerFarms
  # Microsoft.Web.Sites
  topic_type = var.settings.topic_type

  dynamic "identity" {
    for_each = try(var.settings.identity, null) != null ? [var.settings.identity] : []
    content {
      type         = try(identity.value.type, null)
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  tags = local.tags
}
