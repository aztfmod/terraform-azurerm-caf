
resource "azuread_service_principal" "app" {
  application_id                = var.application_id
  app_role_assignment_required  = try(var.settings.app_role_assignment_required, false)
  tags                          = try(var.settings.tags, null)
  account_enabled               = try(var.settings.account_enabled, null)
  alternative_names             = try(var.settings.alternative_names, null)
  description                   = try(var.settings.description, null)
  login_url                     = try(var.settings.login_url, null)
  notes                         = try(var.settings.notes, null)
  notification_email_addresses  = try(var.settings.notification_email_addresses, null)
  preferred_single_sign_on_mode = try(var.settings.preferred_single_sign_on_mode, null)
  use_existing                  = try(var.settings.use_existing, null)

  dynamic "feature_tags" {
    for_each = can(var.settings.feature_tags) ? [1] : []

    content {
      custom_single_sign_on = try(var.settings.feature_tags.custom_single_sign_on, null)
      enterprise            = try(var.settings.feature_tags.enterprise, null)
      gallery               = try(var.settings.feature_tags.gallery, null)
      hide                  = try(var.settings.feature_tags.hide, null)
    }
  }

  dynamic "saml_single_sign_on" {
    for_each = can(var.settings.saml_single_sign_on) ? [1] : []

    content {
      relay_state = try(var.settings.saml_single_sign_on.relay_state, null)
    }
  }

  owners = concat(
    try(var.settings.owners, []),
    [
      var.client_config.object_id
    ]
  )

  # lifecycle {
  #   ignore_changes = [application_id]
  # }
}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [azuread_service_principal.app]

  create_duration = "30s"
}
