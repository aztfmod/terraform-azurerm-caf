# locals {
#     linked_services = {
#     }
# }

##### azurerm_data_factory_linked_service_azure_blob_storage
module "data_factory_linked_service_azure_blob_storage" {
  source = "./modules/data_factory/linked_services/blob"

  for_each = local.data_factory.linked_services.linked_service_azure_blob_storage

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = try(each.value.connection_string, null)
  # global_settings          = local.global_settings
  # base_tags                = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  # tags                     = try(each.value.tags, null)
}

output "data_factory_linked_service_azure_blob_storage" {
  value = module.data_factory_linked_service_azure_blob_storage
}
