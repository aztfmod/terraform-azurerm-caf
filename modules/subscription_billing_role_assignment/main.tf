terraform {
  required_version = ">= 1.1.0"
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
