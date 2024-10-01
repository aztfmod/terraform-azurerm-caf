module "azurerm_dev_center" {
  source = "../../modules/azurerm_dev_center/azurerm_dev_center"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "azurerm_dev_center_catalog" {
  source = "../../modules/azurerm_dev_center/azurerm_dev_center_catalog"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "azurerm_dev_center_dev_box_definition" {
  source = "../../modules/azurerm_dev_center/azurerm_dev_center_dev_box_definition"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "azurerm_dev_center_environment_type" {
  source = "../../modules/azurerm_dev_center/azurerm_dev_center_environment_type"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "azurerm_dev_center_gallery" {
  source = "../../modules/azurerm_dev_center/azurerm_dev_center_gallery"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "azurerm_dev_center_network_connection" {
  source = "../../modules/azurerm_dev_center/azurerm_dev_center_network_connection"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "azurerm_dev_center_project" {
  source = "../../modules/azurerm_dev_center/azurerm_dev_center_project"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "azurerm_dev_center_project_environment_type" {
  source = "../../modules/azurerm_dev_center/azurerm_dev_center_project_environment_type"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}
