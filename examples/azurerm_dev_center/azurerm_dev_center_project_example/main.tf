provider "azurerm" {
  features {}
}

module "azurerm_dev_center_project" {
  source = "../../../modules/azurerm_dev_center/azurerm_dev_center_project"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  dev_center_id       = var.dev_center_id
}

variable "name" {
  description = "The name of the Dev Center Project."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Dev Center Project."
  type        = string
}

variable "location" {
  description = "The location of the Dev Center Project."
  type        = string
}

variable "dev_center_id" {
  description = "The ID of the Dev Center."
  type        = string
}
