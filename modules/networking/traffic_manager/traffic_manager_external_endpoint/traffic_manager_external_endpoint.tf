resource "azurerm_traffic_manager_external_endpoint" "external_endpoint" {

  
  name         = var.settings.name
  profile_id   = var.profile_id
  weight       = var.settings.weight
  target       = var.settings.target
  enabled      = try(var.settings.enabled, "true")
  endpoint_location = try(var.settings.endpoint_location, null )
  priority     = try(var.settings.priority, null ) 
  geo_mappings = try(var.settings.geo_mappings , null )
}