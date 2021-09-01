output "id" {
  value       = azurerm_vmware_express_route_authorization.vwera.id
  description = "The ID of the VMware Private CLoud."
}
output "express_route_authorization_id" {
  value       = azurerm_vmware_express_route_authorization.vwera.express_route_authorization_id
  description = "The ID of the Express Route Circuit Authorization."
}
output "express_route_authorization_key" {
  value       = azurerm_vmware_express_route_authorization.vwera.express_route_authorization_key
  description = "The key of the Express Route Circuit Authorization."
}
# output "express_route_authorization_id" {
#   value       = azurerm_vmware_private_cloud.vwera.express_route_authorization_id
#   description = "The ID of the Express Route Circuit Authorization."
# }
# output "express_route_authorization_key" {
#   value       = azurerm_vmware_private_cloud.vwera.express_route_authorization_key
#   description = "The key of the Express Route Circuit Authorization."
# }