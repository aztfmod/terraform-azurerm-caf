terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    null = {
      source = "hashicorp/null"
    }
  }

}

locals {
  object_id    = coalesce(var.group_id, try(data.azuread_user.upn[0].id, null))
  display_name = var.group_id != null ? var.group_name : var.user_principal_name
}
