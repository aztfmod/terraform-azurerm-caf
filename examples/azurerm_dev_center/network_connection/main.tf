provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "~> 1.2.0"
}

module "network_connection" {
  source              = "../../../modules/azurerm_dev_center/network_connection"
  network_connection_name = "example-network-connection"
  location            = "East US"
  resource_group_name = "example-resource-group"
  subnet_id           = "example-subnet-id"
  domain_name         = "example-domain.com"
  domain_username     = "example-username"
  domain_password     = "example-password"
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

output "network_connection_id" {
  value = module.network_connection.network_connection_id
}

output "network_connection_name" {
  value = module.network_connection.network_connection_name
}

output "network_connection_location" {
  value = module.network_connection.network_connection_location
}

output "network_connection_resource_group_name" {
  value = module.network_connection.network_connection_resource_group_name
}
