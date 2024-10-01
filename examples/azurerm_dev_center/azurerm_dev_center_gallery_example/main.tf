provider "azurerm" {
  features {}
}

module "azurerm_dev_center_gallery" {
  source = "../../../modules/azurerm_dev_center/azurerm_dev_center_gallery"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = var.description
  image_ids           = var.image_ids
}

variable "name" {
  description = "The name of the Dev Center Gallery."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Dev Center Gallery."
  type        = string
}

variable "location" {
  description = "The location/region where the Dev Center Gallery is created."
  type        = string
}

variable "description" {
  description = "The description of the Dev Center Gallery."
  type        = string
}

variable "image_ids" {
  description = "A list of image IDs to include in the Dev Center Gallery."
  type        = list(string)
}
