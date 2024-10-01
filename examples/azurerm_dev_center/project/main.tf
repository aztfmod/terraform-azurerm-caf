provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "~> 1.2.0"
}

module "dev_center_project" {
  source              = "../../../modules/azurerm_dev_center/project"
  project_name        = "example-dev-center-project"
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

output "dev_center_project_id" {
  value = module.dev_center_project.project_id
}

output "dev_center_project_name" {
  value = module.dev_center_project.project_name
}

output "dev_center_project_location" {
  value = module.dev_center_project.project_location
}

output "dev_center_project_resource_group_name" {
  value = module.dev_center_project.project_resource_group_name
}
