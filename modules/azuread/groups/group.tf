resource "azuread_group" "group" {

  name                    = var.azuread_groups.name
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)

}
