resource "azuread_group" "group" {

  display_name            = var.global_settings.passthrough ? format("%s", var.azuread_groups.name) : format("%s%s", try(format("%s-", var.global_settings.prefixes.0), ""), var.azuread_groups.name)
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)
  owners = coalescelist(
    try(tolist(var.azuread_groups.owners), []),
    [
      var.client_config.object_id
    ]
  )
}
