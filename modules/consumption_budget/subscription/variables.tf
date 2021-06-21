variable "client_config" {
  description = "Client configuration object"
}

variable "resource_groups" {
  description = "Map of resource group keys to resource group attributes"
}

variable "settings" {
  description = "Configuration object for the consumption budget subscription"
}

variable "subscription_id" {
  description = "The ID of the Subscription to create the consumption budget for"
  type        = string
}