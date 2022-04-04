resource "azuread_application" "app" {

  display_name = var.global_settings.passthrough || try(var.settings.global_settings.passthrough, false) ? var.settings.application_name : format("%v%s", try(format("%s-", var.global_settings.prefixes[0]), ""), var.settings.application_name)


  owners = coalescelist(
    try(var.settings.owners, []),
    [
      var.client_config.object_id
    ]
  )

  available_to_other_tenants = try(var.settings.available_to_other_tenants, false)
  homepage                   = try(var.settings.homepage, null)
  group_membership_claims    = try(var.settings.group_membership_claims, "All")
  identifier_uris            = try(var.settings.identifier_uris, null)
  logout_url                 = try(var.settings.logout_url, null)
  oauth2_allow_implicit_flow = try(var.settings.oauth2_allow_implicit_flow, false)
  prevent_duplicate_names    = try(var.settings.prevent_duplicate_names, false)
  public_client              = try(var.settings.public_client, false)
  reply_urls                 = try(var.settings.reply_urls, null)

  dynamic "required_resource_access" {
    for_each = var.azuread_api_permissions

    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = {
          for key, resource in required_resource_access.value.resource_access : key => resource
        }

        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }

}
