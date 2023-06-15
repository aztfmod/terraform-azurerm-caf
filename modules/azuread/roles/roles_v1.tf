resource "azuread_directory_role" "v1" {
  for_each = {
    for key in var.azuread_roles : key => key
    if try(var.settings.version, "") == "v1"
  }

  display_name = each.key
}

resource "azuread_directory_role_assignment" "v1" {
  for_each = {
    for key in var.azuread_roles : key => key
    if try(var.settings.version, "") == "v1"
  }

  role_id             = azuread_directory_role.v1[each.key].template_id
  principal_object_id = var.object_id
}