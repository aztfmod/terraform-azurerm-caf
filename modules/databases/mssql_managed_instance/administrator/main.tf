terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  object_id    = coalesce(var.group_id, try(data.azuread_user.upn[0].id, null))
  display_name = var.group_id != null ? var.group_name : var.user_principal_name
}