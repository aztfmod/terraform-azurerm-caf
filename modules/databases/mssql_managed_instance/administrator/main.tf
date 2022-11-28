terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }

}

locals {
  object_id    = coalesce(var.group_id, try(data.azuread_user.upn[0].id, null))
  display_name = var.group_id != null ? var.group_name : var.user_principal_name
}