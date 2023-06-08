variable "name" {
  description = "(Required) Specifies the name of the Application Insights WebTest. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. It needs to correlate with location of parent resource (azurerm_application_insights)."
  type        = string
}

variable "resource_group_id" {
  description = "(Required) The id of the resource group in which to create the Application Insights WebTest. Changing this forces a new resource."
}

variable "application_insights_id" {
  description = "(Required) The ID of the Application Insights component on which the WebTest operates. Changing this forces a new resource to be created."
}

variable "global_settings" {
  description = "Global settings object when the resource is deploye in landing zones context."
  default     = null
  type        = any
}

variable "settings" {
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}
