variable "name" {
  description = "(Required) Name of the Azure Firewall to be created"
}

variable "location" {
  description = "(Required) Location of the Azure Firewall to be created"
}

variable "tags" {
  description = "(Required) Tags of the Azure Firewall to be created"
}

variable "resource_group_name" {
  description = "(Required) Resource Group of the Azure Firewall to be created"
}

variable "diagnostics_map" {
  description = "(Required) Storage Account and Event Hub data for the AzFW diagnostics"
}

variable "la_workspace_id" {
  description = "(Required) ID of Log Analytics data for the AzFW diagnostics"
}

variable "subnet_id" {
  description = "(Required) ID for the subnet where to deploy the Azure Firewall "
}

variable "public_ip_id" {
  description = "(Required) Public IP address identifier. IP address must be of type static and standard."
}

variable "diagnostics_settings" {
  description = "(Required) Map with the diagnostics settings for AzFW deployment"
}

variable "convention" {
  description = "(Required) Naming convention method to use"
}

variable "prefix" {
  description = "(Optional) You can use a prefix to the name of the resource"
  type        = string
  default     = ""
}

variable "postfix" {
  description = "(Optional) You can use a postfix to the name of the resource"
  type        = string
  default     = ""
}

variable "max_length" {
  description = "(Optional) You can speficy a maximum length to the name of the resource"
  type        = string
  default     = "50"
}

