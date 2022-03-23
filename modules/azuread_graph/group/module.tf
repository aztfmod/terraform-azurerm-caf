
resource "azuread_group" "gro" {
  display_name               = var.settings.display_name
  assignable_to_role         = try(var.settings.assignable_to_role, null)
  auto_subscribe_new_members = try(var.settings.auto_subscribe_new_members, null)
  behaviors                  = try(var.settings.behaviors, null)
  description                = try(var.settings.description, null)
  dynamic "dynamic_membership" {
    for_each = try(var.settings.dynamic_membership, null) != null ? [var.settings.dynamic_membership] : []
    content {
      enabled = dynamic_membership.value.enabled
      rule    = dynamic_membership.value.rule
    }
  }
  external_senders_allowed  = try(var.settings.external_senders_allowed, null)
  hide_from_address_lists   = try(var.settings.hide_from_address_lists, null)
  hide_from_outlook_clients = try(var.settings.hide_from_outlook_clients, null)
  mail_enabled              = try(var.settings.mail_enabled, null)
  mail_nickname             = try(var.settings.mail_nickname, null)
  members                   = try(tolist(var.settings.members), [])
  owners = coalescelist(
    try(tolist(var.settings.owners), []),
    [
      var.client_config.object_id
    ]
  )
  prevent_duplicate_names = try(var.settings.prevent_duplicate_names, null)
  provisioning_options    = try(var.settings.provisioning_options, null)
  security_enabled        = try(var.settings.security_enabled, null)
  theme                   = try(var.settings.theme, null)
  types                   = try(var.settings.types, null)
  visibility              = try(var.settings.visibility, null)
}
