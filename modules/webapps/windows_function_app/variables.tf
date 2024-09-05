variable "name" {
  description = "The name of the resource"

}

variable "global_settings" {
  description = "Global settings for the Azure resources"
}

variable "service_plan_id" {
  description = "The ID of the Service Plan"

}

variable "settings" {
  description = "Settings for the Azure Function App"

}

variable "location" {
  description = "The location of the Azure resources"

}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"

}

variable "resource_group" {
  description = "The resource group object in which the resources will be created"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"

}

variable "app_settings" {
  description = "App settings for the Azure Function App"

}

variable "connection_strings" {
  description = "Connection strings for the Azure Function App"

}

variable "identity" {
  description = "Managed Service Identity for the Azure Function App"

}

variable "combined_objects" {
  description = "Combined objects for the Azure Function App"
}

variable "client_config" {
  description = "Client configuration for the Azure Function App"

}

variable "application_insight" {
  description = "Application Insight for the Azure Function App"

}

variable "private_endpoints" {
  description = "Private endpoints for the Azure Function App"

}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "remote_objects" {
  default = null
}

variable "virtual_subnets" {
  description = "Map of virtual_subnets objects"
  default     = {}
  nullable    = false
}

variable "private_dns" {
  description = "Map of private_dns objects"
  default     = {}
  nullable    = false
}

variable "vnets" {
  description = "Map of vnets objects"
  default     = {}
  nullable    = false
}

variable "storage_account_name" {
  description = "The name of the storage account"

}

variable "storage_account_access_key" {
  description = "The access key of the storage account"

}

variable "dynamic_app_settings" {
  default = {}
}