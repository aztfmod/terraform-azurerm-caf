# module "diagnostics_asr" {
#   source  = "../diagnostics"
  
#     name                            = azurerm_recovery_services_vault.asr_rg_vault.name
#     resource_id                     = azurerm_recovery_services_vault.asr_rg_vault.id
#     log_analytics_workspace_id      = var.la_workspace_id
#     diagnostics_map                 = var.diagnostics_map
#     diag_object                     = var.diagnostics_settings
# }