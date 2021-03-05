resource "azuread_group" "group" {

  name                    = var.global_settings.passthrough ? format("%s", var.azuread_groups.name) : format("%s-%s", var.global_settings.prefix.0, var.azuread_groups.name)
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)

}
