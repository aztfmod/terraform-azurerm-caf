/*
resource "azurerm_traffic_manager_external_endpoint" "external_endpoint" {
  depends_on = [azurerm_traffic_manager_profile.traffic_manager_profile]
  for_each     = try(var.settings.external_endpoint, {})
  
  name         = try(var.settings.external_endpoint[each.key].name, null )
  profile_id   = azurerm_traffic_manager_profile.traffic_manager_profile.id
  weight       = try(var.settings.external_endpoint[each.key].weight, null )
  target       = try(var.settings.external_endpoint[each.key].target, null )
  enabled      = try(var.settings.external_endpoint[each.key].enabled, "true" )
  endpoint_location = try(var.settings.external_endpoint[each.key].endpoint_location, null )
  priority     = try(var.settings.external_endpoint[each.key].priority, null )
  geo_mappings = try(var.settings.external_endpoint[each.key].geo_mappings, null )
}


resource "azurerm_traffic_manager_external_endpoint" "external_endpoint" {
  depends_on = [azurerm_traffic_manager_profile.traffic_manager_profile]
  for_each     = try(var.settings.external_endpoint, {})
  
  name         = each.value.name
  profile_id   = azurerm_traffic_manager_profile.traffic_manager_profile.id
  weight       = each.value.weight
  target       = each.value.target
  enabled      = try(each.value.enabled, "true")
  endpoint_location = try(each.value.endpoint_location, null )
  priority     = try(each.value.priority, null ) 
  geo_mappings = try(each.value.geo_mappings , null )
}

resource "azurerm_traffic_manager_endpoint" "endpoint" {
  depends_on = [azurerm_traffic_manager_profile.traffic_manager_profile]
  for_each     = try(var.settings.endpoint, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager_profile.name
  target              = try(each.value.target, null)
  type                = try(each.value.type, "externalEndpoints")
  weight              = try(each.value.weight, null)
}

resource "azurerm_traffic_manager_nested_endpoint" "test" {
  depends_on = [azurerm_traffic_manager_profile.traffic_manager_profile]
  for_each     = try(var.settings.nested_endpoint, {})  
 
  name                = each.value.name
  target_resource_id  = azurerm_traffic_manager_profile.traffic_manager_profile[each.value.target_resource_id].id
  priority            = 1
  profile_id          = azurerm_traffic_manager_profile.traffic_manager_profile[each.value.profile_id].id
  minimum_child_endpoints = 5
  weight              = 1
}
*/