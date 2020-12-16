output "id" {
  value = azurerm_frontdoor.frontdoor.id
}

output "frontend_id" {
  value = azurerm_frontdoor.frontdoor.frontend_endpoint[0].id
}

# output "front_door_firewall_id" {
#   value = azurerm_frontdoor_firewall_policy.wafpolicy.id
# }
