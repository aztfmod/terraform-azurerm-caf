resource "azurecaf_name" "latr" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_trigger_recurrence"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
# Last review :  AzureRM version 2.74.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_trigger_recurrence
resource "azurerm_logic_app_trigger_recurrence" "latr" {
  name         = azurecaf_name.latr.result
  logic_app_id = var.logic_app_id
  frequency    = var.settings.frequency
  interval     = var.settings.interval
  start_time   = try(var.settings.start_time, null)
  time_zone    = try(var.settings.time_zone, null)
  #schedule        = try(var.settings.schedule, null)
}
