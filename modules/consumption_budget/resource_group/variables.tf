variable "client_config" {
  description = "Client configuration object"
}

variable "global_settings" {
  description = "Global settings object"
}

variable "monitor_action_groups" {
  description = "Map of monitor action group keys to monitor action groups group ids"
}

variable "resource_group_id" {
  description = "The ID of the Resource Group to create the consumption budget for in the form of /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1"
  type        = string
}

variable "resource_groups" {
  description = "Map of resource group keys to resource group attributes"
}

variable "settings" {
  description = "Configuration object for the consumption budget resource group"
}