# naming convention
resource "azurecaf_name" "wp" {
  name          = var.settings.application_insight_name
  prefix        = [var.global_settings.prefix]
  resource_type = "azurerm_machine_learning_workspace"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough    = var.global_settings.passthrough
}

# ML Workspace
resource "azurerm_machine_learning_workspace" "ws" {
  name                    = azurecaf_name.wp.result
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = var.application_insights_id
  key_vault_id            = var.keyvault_id
  storage_account_id      = var.storage_account_id
  tags                    = try(var.settings.tags, null)
  sku                     = try(var.settings.sku, "basic")

  identity {
    type = "SystemAssigned"
  }
}


#------------------------

/* resource "azurecaf_name" "apin" {
  name          = var.settings.application_insight_name
  prefix        = [var.global_settings.prefix]
  resource_type = "azurerm_application_insight"
  random_length = var.global_settings.random_length
  clean_input   = true
  convention    = var.global_settings.passthrough
} */

/* resource "azurerm_resource_group" "rg_dap_aml" {
  name     = azurecaf_naming_convention.nc_aml_rg.result
  location = var.location
} */

/* 
module "aml_storage" {
  source = "../module_azure_storage"

  prefix                 = var.prefix
  convention             = var.convention
  resource_group_name    = azurerm_resource_group.rg_dap_aml.name
  location               = var.location
  storage_account_config = var.aml_config.storage_account
  subnet_ids             = var.subnet_ids
}

# Insight ID for ML Workspace
resource "azurerm_application_insights" "ml_workspace_insight" {
  name                = azurecaf_naming_convention.nc_aml_appinsight.result
  location            = azurerm_resource_group.rg_dap_aml.location
  resource_group_name = azurerm_resource_group.rg_dap_aml.name
  application_type    = "web"

  depends_on = [azurerm_resource_group.rg_dap_aml]
}
 */

/* # Keyvault for ML Workspace
module "caf-keyvault" {
  source = "github.com/aztfmod/terraform-azurerm-caf-keyvault?ref=vnext"
  # source  = "aztfmod/caf-keyvault/azurerm"
  # version = "2.0.2"

  prefix                  = var.prefix
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg_dap_aml.name
  akv_config              = var.akv_config
  tags                    = var.tags
  diagnostics_settings    = var.akv_config.diagnostics
  diagnostics_map         = var.diagnostics_map
  log_analytics_workspace = var.log_analytics_workspace
  convention              = "passthrough"
} */


