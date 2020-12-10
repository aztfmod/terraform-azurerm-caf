resource "azurerm_logic_app_trigger_recurrence" "freq" {
  name         = var.name
  logic_app_id = var.logic_app_id
  frequency    = var.frequency
  interval     = var.interval
  start_time   = var.start_time
  # time_zone            = var.time_zone  
}
