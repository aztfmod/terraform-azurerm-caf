resource "azurerm_data_factory_dataset_http" "dataset" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  data_factory_name     = var.data_factory_name
  linked_service_name   = var.linked_service_name
  folder                = var.folder
  description           = var.description
  annotations           = var.annotations
  parameters            = var.parameters
  additional_properties = var.additional_properties
  relative_url          = var.relative_url
  request_body          = var.request_body
  request_method        = var.request_method

  dynamic "schema_column" {
    for_each = lookup(var.settings, "schema_column", {}) == {} ? [] : [1]

    content {
      name        = var.settings.schema_column.name
      type        = var.settings.schema_column.type
      description = var.settings.schema_column.description
    }
  }
}
