resource "azurecaf_name" "lsabs" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory_linked_service_azure_blob_storage" #azurerm_data_factory_linked_service_azure_blob_storage
  prefixes      = var.global_settings.prefixes
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
  integration_runtime_name = try(var.settings.integration_runtime_name, var.integration_runtime_name)
  annotations              = try(var.settings.annotations, null)
  parameters               = try(var.settings.parameters, null)
  additional_properties    = try(var.settings.additional_properties, null)
  use_managed_identity     = try(var.settings.use_managed_identity, null)
  service_principal_id     = try(var.settings.service_principal_id, null)
  service_principal_key    = try(var.settings.service_principal_key, null)
  tenant_id                = try(var.settings.tenant_id, null)

  service_endpoint = can(var.settings.use_managed_identity) ? try(var.settings.service_endpoint, var.storage_account.primary_blob_endpoint) : null
  sas_uri          = try(var.settings.sas_uri, null)
  connection_string = try(
    try(var.storage_account.primary_blob_connection_string, null),
    var.settings.connection_string,
    var.connection_string,
    null
  )

  dynamic "key_vault_sas_token" {
    for_each = try(var.settings.key_vault_sas_token, null) != null ? [var.settings.key_vault_sas_token] : []

    content {
      linked_service_name = key_vault_sas_token.value.linked_service_name
      secret_name         = key_vault_sas_token.value.secret_name
    }
  }
}