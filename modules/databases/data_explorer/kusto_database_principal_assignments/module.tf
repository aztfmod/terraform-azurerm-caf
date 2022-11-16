resource "azurecaf_name" "kusto" {
  name          = var.settings.name
  resource_type = "azurerm_kusto_cluster" #azurerm_kusto_database_principal_assignment
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.77.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database_principal_assignment

resource "azurerm_kusto_database_principal_assignment" "kusto" {
  name                = azurecaf_name.kusto.result
  resource_group_name = var.resource_group_name
  cluster_name        = var.cluster_name
  database_name       = var.database_name
  principal_id        = var.principal_id
  principal_type      = try(var.settings.principal_type, null)
  role                = try(var.settings.role, null)
  tenant_id           = try(var.tenant_id, null)
}