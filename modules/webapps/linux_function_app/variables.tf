variable "name" {
  description = "The name of the resource"
  type        = string
}

variable "global_settings" {
  description = "Global settings for the Azure resources"
  type        = map(any)
}

variable "service_plan_id" {
  description = "The ID of the Service Plan"
  type        = string
}

variable "settings" {
  description = "Settings for the Azure Function App"
  type        = map(any)
}

variable "location" {
  description = "The location of the Azure resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}

variable "app_settings" {
  description = "App settings for the Azure Function App"
  type        = map(any)
}

variable "connection_strings" {
  description = "Connection strings for the Azure Function App"
  type        = list(map(any))
}

variable "identity" {
  description = "Managed Service Identity for the Azure Function App"
  type        = map(any)
}


variable "combined_objects" {
  description = "Combined objects for the Azure Function App"
  type        = map(any)
}

variable "client_config" {
  description = "Client configuration for the Azure Function App"
  type        = map(any)
}


variable "var.application_insight" {
  description = "Application Insight for the Azure Function App"
  type        = map(any)
}
