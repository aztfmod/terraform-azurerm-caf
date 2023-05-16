terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.48"
    }
    random = {
      version = "~> 3.3.1"
      source  = "hashicorp/random"
    }
  }
}
