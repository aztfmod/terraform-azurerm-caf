resource "azurecaf_name" "evhub" {
  name          = var.settings.name
  resource_type = "azurerm_eventhub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last reviewed :  AzureRM version 2.64.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule

resource "azurerm_eventhub" "evhub" {
  name                = azurecaf_name.evhub.result
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group.name
  partition_count     = var.settings.partition_count
  message_retention   = var.settings.message_retention
  status              = try(var.settings.status, null)

  dynamic "capture_description" {
    for_each = try(var.settings.capture_description, false) == false ? [] : [1]
    content {
      enabled             = var.settings.capture_description.enabled
      encoding            = var.settings.capture_description.encoding
      interval_in_seconds = try(var.settings.capture_description.interval_in_seconds, null)
      size_limit_in_bytes = try(var.settings.capture_description.size_limit_in_bytes, null)
      skip_empty_archives = try(var.settings.capture_description.skip_empty_archives, null)

      dynamic "destination" { # required if capture_description is set
        for_each = try(var.settings.capture_description.destination, false) == false ? [] : [1]
        content {
          name                = var.settings.capture_description.destination.name                # At this time(12/2020), the only supported value is EventHubArchive.AzureBlockBlob
          archive_name_format = var.settings.capture_description.destination.archive_name_format # e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}
          blob_container_name = var.settings.capture_description.destination.blob_container_name
          storage_account_id  = var.storage_account_id
        }
      }
    }
  }
}

