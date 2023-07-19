locals {
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.name)
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}
