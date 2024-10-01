provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "~> 1.2.0"
}

module "environment_type" {
  source              = "../../../modules/azurerm_dev_center/environment_type"
  environment_type_name = "example-environment-type"
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

output "environment_type_id" {
  value = module.environment_type.environment_type_id
}

output "environment_type_name" {
  value = module.environment_type.environment_type_name
}

output "environment_type_location" {
  value = module.environment_type.environment_type_location
}

output "environment_type_resource_group_name" {
  value = module.environment_type.environment_type_resource_group_name
}
