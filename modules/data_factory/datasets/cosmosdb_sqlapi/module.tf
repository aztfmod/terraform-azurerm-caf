resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "dataset" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  data_factory_name     = var.data_factory_name
  linked_service_name   = var.linked_service_name
  folder                = try(var.folder, null)
  description           = try(var.description, null)
  annotations           = try(var.annotations, null)
  parameters            = try(var.parameters, null)
  additional_properties = try(var.additional_properties, null)
  collection_name       = try(var.collection_name, null)

  dynamic "schema_column" {
    for_each = lookup(var.settings, "schema_column", {}) == {} ? [] : [1]

    content {
      name        = var.settings.schema_column.name
      type        = try(var.settings.schema_column.type, null)
      description = try(var.settings.schema_column.description, null)
    }
  }
}