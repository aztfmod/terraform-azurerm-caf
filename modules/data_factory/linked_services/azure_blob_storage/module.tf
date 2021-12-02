resource "azurecaf_name" "lsabs" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #azurerm_data_factory_linked_service_azure_blob_storage
  prefixes      = var.global_settings.prefixes
  suffixes      = var.global_settings.suffixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "linked_service_azure_blob_storage" {
  name                     = azurecaf_name.lsabs.result
  resource_group_name      = var.resource_group_name
  data_factory_name        = var.data_factory_name
  description              = try(var.settings.description, null)
  integration_runtime_name = try(var.settings.integration_runtime_name, null)
  annotations              = try(var.settings.annotations, null)
  parameters               = try(var.settings.parameters, null)
  additional_properties    = try(var.settings.additional_properties, null)
  connection_string        = try(var.connection_string, null)
  sas_uri                  = try(var.settings.sas_uri, null)
  service_endpoint         = try(var.settings.service_endpoint, null)
  use_managed_identity     = try(var.settings.value.use_managed_identity, null)
  service_principal_id     = try(var.settings.value.service_principal_id, null)
  service_principal_key    = try(var.settings.value.service_principal_key, null)
  tenant_id                = try(var.settings.value.tenant_id, null)

  dynamic "key_vault_sas_token" {
    for_each = try(var.settings.key_vault_sas_token, null) != null ? [var.settings.key_vault_sas_token] : []

    content {
      linked_service_name = key_vault_sas_token.value.linked_service_name
      secret_name         = key_vault_sas_token.value.secret_name
    }
  }
}