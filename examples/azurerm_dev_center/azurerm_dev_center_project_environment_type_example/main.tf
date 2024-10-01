provider "azurerm" {
  features {}
}

module "azurerm_dev_center_project_environment_type" {
  source = "../../../modules/azurerm_dev_center/azurerm_dev_center_project_environment_type"

  project_environment_type_name = var.project_environment_type_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tags                          = var.tags
  global_settings               = var.global_settings
}

variable "project_environment_type_name" {
  description = "The name of the Project Environment Type."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Project Environment Type."
  type        = string
}

variable "location" {
  description = "The location of the Project Environment Type."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "global_settings" {
  description = "Global settings for naming conventions and other configurations."
  type = object({
    prefixes      = list(string)
    random_length = number
    passthrough   = bool
    use_slug      = bool
  })
}
