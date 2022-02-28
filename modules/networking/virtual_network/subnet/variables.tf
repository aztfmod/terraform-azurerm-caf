variable "name" {
  description = "(Required) The name of the subnet. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the subnet."
  type        = string
}
variable "virtual_network_name" {
  description = "(Required) The name of the virtual network to which to attach the subnet."
}
variable "address_prefixes" {
  description = "(Optional) The address prefixes to use for the subnet."
  default     = []
}
variable "enforce_private_link_endpoint_network_policies" {
  description = "(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Default value is false. Conflicts with enforce_private_link_service_network_policies."
  default     = null
}
variable "enforce_private_link_service_network_policies" {
  description = "(Optional) Enable or Disable network policies for the private link service on the subnet. Default valule is false. Conflicts with enforce_private_link_endpoint_network_policies."
  default     = null
}
variable "service_endpoints" {
  description = "(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default     = []
  # validation {
  #   condition     = var.service_endpoints == [] || contains(["Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Web"], var.service_endpoints)
  #   error_message = "Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  # }
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "settings" {}