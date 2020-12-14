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
    for_each = lookup(var.settings, "http_server_location", {}) == {} ? [] : [1]

    content {
      relative_url = var.settings.relative_url
      path         = var.settings.path
      filename     = var.settings.filename
    }
  }

  dynamic "azure_blob_storage_location" {
    for_each = lookup(var.settings, "azure_blob_storage_location", {}) == {} ? [] : [1]

    content {
      container = var.settings.container
      path      = var.settings.path
      filename  = var.settings.filename
    }
  }

  dynamic "schema_column" {
    for_each = lookup(var.settings, "schema_column", {}) == {} ? [] : [1]

    content {
      name        = var.settings.schema_column.name
      type        = var.settings.schema_column.type
      description = var.settings.schema_column.description
    }
  }
}