output "id" {
  description = "Resource ID of the Virtual Hub"
  value       = azurerm_virtual_hub.vwan_hub.id
}

output "object" {
  description = "Full Virtual Hub Object"
  value       = azurerm_virtual_hub.vwan_hub
}

output "name" {
  description = "Name of the Virtual Hub"
  value       = azurerm_virtual_hub.vwan_hub.name
}

output "firewall_id" {
  description = "Resource ID of the Azure Firewall for Virtual Hub"
  value       = try(var.virtual_hub_config.deploy_firewall, false) ? jsondecode(azurerm_resource_group_template_deployment.arm_template_vhub_firewall.0.output_content).resourceID : null
}

# output virtual network gateway objects: p2s, s2s, er objects
output "er_gateway" {
  description = "Full Object for Virtual Network Gateway - Express Route"
  value       = try(var.virtual_hub_config.deploy_er, false) ? azurerm_express_route_gateway.er_gateway.0 : null
}

output "s2s_gateway" {
  description = "Full Object for Virtual Network Gateway - Site 2 Site"
  value       = try(var.virtual_hub_config.deploy_s2s, false) ? azurerm_vpn_gateway.s2s_gateway.0 : null
}

output "p2s_gateway" {
  description = "Full Object for Virtual Network Gateway - Point to Site"
  value       = try(var.virtual_hub_config.deploy_p2s, false) ? azurerm_point_to_site_vpn_gateway.p2s_gateway.0 : null
}

output "resource_group_name" {
  description = "Name of the resource group where the resources are deployed."
  value       = var.resource_group_name
}

output "default_route_table_id" {
  description = "Resource ID of the Virtual Hub Default Route Table"
  value       = azurerm_virtual_hub.vwan_hub.default_route_table_id
}
