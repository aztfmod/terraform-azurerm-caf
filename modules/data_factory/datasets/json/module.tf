resource "azurecaf_name" "dataset" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_data_factory_dataset_azure_blob"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_data_factory_dataset_json" "dataset" {
  name                  = azurecaf_name.dataset.name
  resource_group_name   = var.resource_group_name
  data_factory_name     = var.data_factory_name
  linked_service_name   = var.linked_service_name
  folder                = try(var.settings.folder, null)
  description           = try(var.settings.description, null)
  annotations           = try(var.settings.annotations, null)
  parameters            = try(var.settings.parameters, null)
  additional_properties = try(var.settings.additional_properties, null)
  encoding              = var.settings.encoding

  dynamic "http_server_location" {
    for_each = try(var.settings.http_server_location, null) != null ? [var.settings.http_server_location] : []

    content {
      relative_url = http_server_location.value.relative_url
      path         = http_server_location.value.path
      filename     = http_server_location.value.filename
    }
  }

  dynamic "azure_blob_storage_location" {
    for_each = try(var.settings.azure_blob_storage_location, null) != null ? [var.settings.azure_blob_storage_location] : []

    content {
      container = azure_blob_storage_location.value.container
      path      = azure_blob_storage_location.value.path
      filename  = azure_blob_storage_location.value.filename
    }
  }

  dynamic "schema_column" {
    for_each = try(var.settings.sche1ma_column, null) != null ? [var.settings.schema_column] : []

    content {
      name        = schema_column.value.name
      type        = lookup(schema_column.value, "type", null)
      description = lookup(schema_column.value, "description", null)
    }
  }
}