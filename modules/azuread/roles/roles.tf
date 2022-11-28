# azuread provider includes new resource type, no need to call shell script to assign azuread roles
resource "azuread_directory_role" "roles" {
  for_each = {
    for key in var.azuread_roles : key => key
  }
  display_name = each.key
}

resource "azuread_directory_role_assignment" "assignments" {
  for_each = resource.azuread_directory_role.roles

  role_id             = resource.azuread_directory_role.roles[each.key].template_id
  principal_object_id = var.object_id
}
