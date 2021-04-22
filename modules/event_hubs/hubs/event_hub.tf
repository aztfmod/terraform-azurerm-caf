resource "azurecaf_name" "evhub" {
  name          = var.settings.name
  resource_type = "azurerm_eventhub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_eventhub" "evhub" {
  name                = azurecaf_name.evhub.result
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = var.settings.partition_count
  message_retention   = var.settings.message_retention

  dynamic "capture_description" {
    for_each = try(var.settings.capture_description, {})
    content {
      enabled             = capture_description.value.enabled
      encoding            = capture_description.value.encoding
      interval_in_seconds = try(capture_description.value.interval_in_seconds, null)
      size_limit_in_bytes = try(capture_description.value.size_limit_in_bytes, null)
      skip_empty_archives = try(capture_description.value.skip_empty_archives, null)
      dynamic "destination" { # required if capture_description is set
        for_each = try(var.settings.capture_description.destination, {})
        content {
          name                = destination.value.name                # At this time(12/2020), the only supported value is EventHubArchive.AzureBlockBlob
          archive_name_format = destination.value.archive_name_format # e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}
          blob_container_name = destination.value.blob_container_name
          storage_account_id  = var.storage_account_id
        }
      }
    }
  }
}

