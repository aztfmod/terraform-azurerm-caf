##### azurerm_data_factory_linked_service_azure_blob_storage
module "data_factory_linked_service_azure_blob_storage" {
  source = "./modules/data_factory/linked_services/azure_blob_storage"

  for_each = local.data_factory.linked_services.azure_blob_storage

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "data_factory_linked_service_azure_blob_storage" {
  value = module.data_factory_linked_service_azure_blob_storage
}