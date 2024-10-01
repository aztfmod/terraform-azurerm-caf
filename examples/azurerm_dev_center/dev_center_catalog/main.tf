provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "~> 1.2.0"
}

module "dev_center_catalog" {
  source              = "../../../modules/azurerm_dev_center/dev_center_catalog"
  dev_center_catalog_name = "example-dev-center-catalog"
  location            = "East US"
  resource_group_name = "example-resource-group"
  tags                = {
    environment = "example"
  }
  global_settings = {
    prefixes      = ["example"]
    random_length = 8
    passthrough   = false
    use_slug      = true
  }
}

output "dev_center_catalog_id" {
  value = module.dev_center_catalog.dev_center_catalog_id
}

output "dev_center_catalog_name" {
  value = module.dev_center_catalog.dev_center_catalog_name
}

output "dev_center_catalog_location" {
  value = module.dev_center_catalog.dev_center_catalog_location
}

output "dev_center_catalog_resource_group_name" {
  value = module.dev_center_catalog.dev_center_catalog_resource_group_name
}
