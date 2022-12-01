
resource "azuread_group" "group" {
  display_name               = var.global_settings.passthrough ? format("%s", var.settings.name) : format("%s%s", try(format("%s-", var.global_settings.prefixes.0), ""), var.settings.name)
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
  # Group membership managed by azuread_groups_membership in order to avoid conflicts with members property.
  # members                   = try(var.settings.members, null)
  owners                  = local.owners
  prevent_duplicate_names = try(var.settings.prevent_duplicate_names, null)
  provisioning_options    = try(var.settings.provisioning_options, null)
  security_enabled        = try(var.settings.security_enabled, null)
  theme                   = try(var.settings.theme, null)
  types                   = try(var.settings.types, null)
  visibility              = try(var.settings.visibility, null)
}

data "azuread_user" "main" {
  for_each            = try(toset(var.settings.owners.user_principal_names), {})
  user_principal_name = each.value
}

locals {
  owners = concat(
    try(tolist(var.settings.owners), []),
    local.ad_user_oids,
    [var.client_config.object_id]
  )
  ad_user_oids = [for user in try(var.settings.owners.user_principal_names, []) :
    data.azuread_user.main[user].object_id
  ]
}