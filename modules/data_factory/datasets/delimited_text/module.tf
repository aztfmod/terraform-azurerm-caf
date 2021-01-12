resource "azurerm_data_factory_dataset_delimited_text" "dataset" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  data_factory_name     = var.data_factory_name
  linked_service_name   = var.linked_service_name
  folder                = try(var.folder, null)
  description           = try(var.description, null)
  annotations           = try(var.annotations, null)
  parameters            = try(var.parameters, null)
  additional_properties = try(var.additional_properties, null)
  column_delimiter      = var.column_delimiter
  row_delimiter         = var.row_delimiter
  encoding              = var.encoding
  quote_character       = var.quote_character
  escape_character      = var.escape_character
  first_row_as_header   = var.first_row_as_header
  null_value            = var.null_value

  dynamic "http_server_location" {
    for_each = try(var.http_server_location, null) != null ? [var.http_server_location] : []

    content {
      relative_url = http_server_location.value.relative_url
      path         = http_server_location.value.path
      filename     = http_server_location.value.filename
    }
  }

  dynamic "azure_blob_storage_location" {
    for_each = try(var.azure_blob_storage_location, null) != null ? [var.azure_blob_storage_location] : []

    content {
      container = azure_blob_storage_location.value.container
      path      = azure_blob_storage_location.value.path
      filename  = azure_blob_storage_location.value.filename
    }
  }

  dynamic "schema_column" {
    for_each = try(var.schema_column, null) != null ? [var.schema_column] : []

    content {
      name        = schema_column.value.name
      type        = lookup(schema_column.value, "type", null)
      description = lookup(schema_column.value, "description", null)
    }
  }
}