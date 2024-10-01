provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "~> 1.2.0"
}

module "dev_center_project_environment_type" {
  source                     = "../../../modules/azurerm_dev_center/project_environment_type"
  project_environment_type_name = "example-dev-center-project-environment-type"
  location                   = "East US"
  resource_group_name        = "example-resource-group"
  tags                       = {
    environment = "example"
  }
  global_settings = {
    prefixes      = ["example"]
    random_length = 8
    passthrough   = false
    use_slug      = true
  }
}

output "dev_center_project_environment_type_id" {
  value = module.dev_center_project_environment_type.project_environment_type_id
}

output "dev_center_project_environment_type_name" {
  value = module.dev_center_project_environment_type.project_environment_type_name
}

output "dev_center_project_environment_type_location" {
  value = module.dev_center_project_environment_type.project_environment_type_location
}

output "dev_center_project_environment_type_resource_group_name" {
  value = module.dev_center_project_environment_type.project_environment_type_resource_group_name
}
