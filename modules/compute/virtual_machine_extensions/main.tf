terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2.3"
    }
  }
}
