terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  location            = coalesce(var.location, var.resource_group.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.name)
}
