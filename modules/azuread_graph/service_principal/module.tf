
data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "app" {
  application_id               = can(var.settings.application.key) == false ? try(var.settings.application.id, data.azuread_application_published_app_ids.well_known.result[var.settings.application.well_known_key]) : var.remote_objects.azuread_applications[try(var.settings.application.lz_key, var.client_config.landingzone_key)][var.settings.application.key].application_id
  account_enabled              = try(var.settings.account_enabled, null)
  alternative_names            = try(var.settings.alternative_names, null)
  app_role_assignment_required = try(var.settings.app_role_assignment_required, null)
  description                  = try(var.settings.description, null)

  dynamic "features" {
    for_each = try(var.settings.features, null) != null ? [var.settings.features] : []
    content {
      custom_single_sign_on_app = try(features.value.custom_single_sign_on_app, null)
      enterprise_application    = try(features.value.enterprise_application, null)
      gallery_application       = try(features.value.gallery_application, null)
      visible_to_users          = try(features.value.visible_to_users, null)
    }
  }
  login_url                     = try(var.settings.login_url, null)
  notes                         = try(var.settings.notes, null)
  notification_email_addresses  = try(var.settings.notification_email_addresses, null)
  owners                        = try(var.settings.owners, null)
  preferred_single_sign_on_mode = try(var.settings.preferred_single_sign_on_mode, null)
  tags                          = try(var.settings.tags, null)
  use_existing                  = try(var.settings.use_existing, null)
  dynamic "saml_single_sign_on" {
    for_each = try(var.settings.saml_single_sign_on, null) != null ? [var.settings.saml_single_sign_on] : []
    content {
      relay_state = try(saml_single_sign_on.value.relay_state, null)
    }
  }
}
