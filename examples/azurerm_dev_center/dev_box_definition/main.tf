provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "~> 1.2.0"
}

module "dev_box_definition" {
  source              = "../../../modules/azurerm_dev_center/dev_box_definition"
  dev_box_definition_name = "example-dev-box-definition"
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

output "dev_box_definition_id" {
  value = module.dev_box_definition.dev_box_definition_id
}

output "dev_box_definition_name" {
  value = module.dev_box_definition.dev_box_definition_name
}

output "dev_box_definition_location" {
  value = module.dev_box_definition.dev_box_definition_location
}

output "dev_box_definition_resource_group_name" {
  value = module.dev_box_definition.dev_box_definition_resource_group_name
}
