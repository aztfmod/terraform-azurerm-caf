provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "~> 1.2.0"
}

module "dev_center" {
  source              = "../../../modules/azurerm_dev_center/dev_center"
  dev_center_name     = "example-dev-center"
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

output "dev_center_id" {
  value = module.dev_center.dev_center_id
}

output "dev_center_name" {
  value = module.dev_center.dev_center_name
}

output "dev_center_location" {
  value = module.dev_center.dev_center_location
}

output "dev_center_resource_group_name" {
  value = module.dev_center.dev_center_resource_group_name
}
