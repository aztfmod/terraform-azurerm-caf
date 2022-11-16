output "id" {
  value       = azurerm_vmware_private_cloud.vwpc.id
  description = "The ID of the VMware Private CLoud."
}
output "hcx_cloud_manager_endpoint" {
  value       = azurerm_vmware_private_cloud.vwpc.hcx_cloud_manager_endpoint
  description = " The endpoint for the HCX Cloud Manager."
}
output "nsxt_manager_endpoint" {
  value       = azurerm_vmware_private_cloud.vwpc.nsxt_manager_endpoint
  description = "The endpoint for the NSX-T Data Center manager."
}
output "vcsa_endpoint" {
  value       = azurerm_vmware_private_cloud.vwpc.vcsa_endpoint
  description = "The endpoint for Virtual Center Server Appliance."
}
output "nsxt_certificate_thumbprint" {
  value       = azurerm_vmware_private_cloud.vwpc.nsxt_certificate_thumbprint
  description = "The thumbprint of the NSX-T Manager SSL certificate."
}
output "vcenter_certificate_thumbprint" {
  value       = azurerm_vmware_private_cloud.vwpc.vcenter_certificate_thumbprint
  description = " The thumbprint of the vCenter Server SSL certificate."
}
output "management_subnet_cidr" {
  value       = azurerm_vmware_private_cloud.vwpc.management_subnet_cidr
  description = "The network used to access vCenter Server and NSX-T Manager."
}
output "provisioning_subnet_cidr" {
  value       = azurerm_vmware_private_cloud.vwpc.provisioning_subnet_cidr
  description = "The network which is used for virtual machine cold migration, cloning, and snapshot migration."
}
output "vmotion_subnet_cidr" {
  value       = azurerm_vmware_private_cloud.vwpc.vmotion_subnet_cidr
  description = "The network which is used for live migration of virtual machines."
}
output "circuit" {
  value       = azurerm_vmware_private_cloud.vwpc.circuit
  description = "A `circuit` block as defined below."
}
output "management_cluster" {
  value       = azurerm_vmware_private_cloud.vwpc.management_cluster
  description = "A management_cluster block as defined below."
}
# output "management_cluster" {
#   value       = {
#     for key, value in azurerm_vmware_private_cloud.vwpc.management_cluster : key => {
#       id = azurerm_vmware_private_cloud.vwpc.management_cluster[key].id
#       hosts = azurerm_vmware_private_cloud.vwpc.management_cluster[key].hosts
#     }
#   }
# }
# output "circuit" {
#   value       = {
#     for key, value in azurerm_vmware_private_cloud.vwpc.circuit : key => {
#       express_route_id = azurerm_vmware_private_cloud.vwpc.circuit[key].express_route_id
#       express_route_private_peering_id  = azurerm_vmware_private_cloud.vwpc.circuit[key].express_route_private_peering_id
#       primary_subnet_cidr   = azurerm_vmware_private_cloud.vwpc.circuit[key].primary_subnet_cidr
#       secondary_subnet_cidr  = azurerm_vmware_private_cloud.vwpc.circuit[key].secondary_subnet_cidr
#     }
#   }
# }
