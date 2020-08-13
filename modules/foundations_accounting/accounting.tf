
#Specify the operations diagnostic logging repositories 
module "diagnostics_logging" {
  source = "github.com/aztfmod/terraform-azurerm-caf-diagnostics-logging?ref=vnext"
  # source  = "aztfmod/caf-diagnostics-logging/azurerm"
  # version = "2.0.1"

  convention          = var.global_settings.convention
  name                = var.accounting_settings.azure_diagnostics_logs_name
  enable_event_hub    = var.accounting_settings.azure_diagnostics_logs_event_hub
  prefix              = var.global_settings.prefix
  resource_group_name = var.resource_groups[var.accounting_settings.resource_group_key].name
  location            = var.accounting_settings.location
  tags                = local.tags
}

#Create the Azure Monitor - Log Analytics workspace
module "log_analytics" {
  source = "github.com/aztfmod/terraform-azurerm-caf-log-analytics?ref=vnext"
  #version = "2.2.0"

  convention          = var.global_settings.convention
  prefix              = var.global_settings.prefix
  name                = var.accounting_settings.analytics_workspace_name
  solution_plan_map   = var.accounting_settings.solution_plan_map
  resource_group_name = var.resource_groups[var.accounting_settings.resource_group_key].name
  location            = var.accounting_settings.location
  tags                = local.tags
  retention_in_days   = var.accounting_settings.azure_activity_logs_retention
}

#Specify the subscription logging repositories 
module "activity_logs" {
  count  = var.accounting_settings.azure_activity_log_enabled ? 1 : 0
  source = "github.com/aztfmod/terraform-azurerm-caf-activity-logs?ref=vnext"
  # source  = "aztfmod/caf-activity-logs/azurerm"
  # version = "3.0.0"

  convention                 = var.global_settings.convention
  enable_event_hub           = var.accounting_settings.azure_activity_logs_event_hub
  prefix                     = var.global_settings.prefix
  resource_group_name        = var.resource_groups[var.accounting_settings.resource_group_key].name
  location                   = var.accounting_settings.location
  tags                       = local.tags
  log_analytics_workspace_id = module.log_analytics.id
  diagnostic_name            = var.accounting_settings.azure_activity_logs_name
  name                       = var.accounting_settings.azure_activity_logs_name
  audit_settings_object      = var.accounting_settings.azure_activity_audit
}
