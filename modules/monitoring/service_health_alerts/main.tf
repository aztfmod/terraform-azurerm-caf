
terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azapi = {
      version = "~> 1.0.0"
      source = "Azure/azapi"
    }
  }
}

