provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "~> 1.2.0"
}

module "dev_center_gallery" {
  source              = "../../../modules/azurerm_dev_center/gallery"
  dev_center_gallery_name = "example-dev-center-gallery"
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

output "dev_center_gallery_id" {
  value = module.dev_center_gallery.dev_center_gallery_id
}

output "dev_center_gallery_name" {
  value = module.dev_center_gallery.dev_center_gallery_name
}

output "dev_center_gallery_location" {
  value = module.dev_center_gallery.dev_center_gallery_location
}

output "dev_center_gallery_resource_group_name" {
  value = module.dev_center_gallery.dev_center_gallery_resource_group_name
}
