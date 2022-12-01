data "azuread_application_published_app_ids" "well_known" {}
data "azuread_application_template" "template" {
  count        = can(var.settings.template.display_name) ? 1 : 0
  display_name = try(var.settings.template.display_name, null)
}

resource "azuread_application" "app" {
  display_name = var.global_settings.passthrough || try(var.settings.global_settings.passthrough, false) || can(var.settings.useprefix == false) ? var.settings.application_name : format("%v%s", try(format("%s-", var.global_settings.prefixes[0]), ""), var.settings.application_name)
  dynamic "api" {
    for_each = try(var.settings.api, null) != null ? [var.settings.api] : []
    content {
      known_client_applications = try(api.value.known_client_applications, null)
      mapped_claims_enabled     = try(api.value.mapped_claims_enabled, null)
      dynamic "oauth2_permission_scope" {
        for_each = try(api.value.oauth2_permission_scope, null) != null ? [api.value.oauth2_permission_scope] : []
        content {
          id                         = oauth2_permission_scope.value.id
          admin_consent_description  = try(oauth2_permission_scope.value.admin_consent_description, null)
          admin_consent_display_name = try(oauth2_permission_scope.value.admin_consent_display_name, null)
          enabled                    = try(oauth2_permission_scope.value.enabled, null)
          type                       = try(oauth2_permission_scope.value.type, null)
          user_consent_description   = try(oauth2_permission_scope.value.user_consent_description, null)
          user_consent_display_name  = try(oauth2_permission_scope.value.user_consent_display_name, null)
          value                      = try(oauth2_permission_scope.value.value, null)
        }
      }
      requested_access_token_version = try(api.value.requested_access_token_version, null)
    }
  }
  dynamic "app_role" {
    for_each = try(var.settings.app_role, null) != null ? [var.settings.app_role] : []
    content {
      id                   = app_role.value.id
      allowed_member_types = app_role.value.allowed_member_types
      description          = app_role.value.description
      display_name         = app_role.value.display_name
      enabled              = try(app_role.value.enabled, null)
      value                = try(app_role.value.value, null)
    }
  }
  device_only_auth_enabled       = try(var.settings.device_only_auth_enabled, null)
  fallback_public_client_enabled = try(var.settings.fallback_public_client_enabled, null)
  dynamic "feature_tags" {
    for_each = try(var.settings.feature_tags, null) != null ? [var.settings.feature_tags] : []
    content {
      custom_single_sign_on = try(feature_tags.value.custom_single_sign_on, null)
      enterprise            = try(feature_tags.value.enterprise, null)
      gallery               = try(feature_tags.value.gallery, null)
      hide                  = try(feature_tags.value.hide, null)
    }
  }
  group_membership_claims       = try(var.settings.group_membership_claims, ["All"])
  identifier_uris               = try(var.settings.identifier_uris, null)
  logo_image                    = can(var.settings.logo_image) ? filebase64(var.settings.logo_image) : null
  marketing_url                 = try(var.settings.marketing_url, null)
  oauth2_post_response_required = try(var.settings.oauth2_post_response_required, null)
  dynamic "optional_claims" {
    for_each = try(var.settings.optional_claims, null) != null ? [var.settings.optional_claims] : []
    content {
      dynamic "access_token" {
        for_each = try(optional_claims.value.access_token, null) != null ? [optional_claims.value.access_token] : []
        content {
          name                  = access_token.value.name
          source                = try(access_token.value.source, null)
          essential             = try(access_token.value.essential, null)
          additional_properties = try(access_token.value.additional_properties, null)
        }
      }
      dynamic "id_token" {
        for_each = try(optional_claims.value.id_token, null) != null ? [optional_claims.value.id_token] : []
        content {
          name                  = id_token.value.name
          source                = try(id_token.value.source, null)
          essential             = try(id_token.value.essential, null)
          additional_properties = try(id_token.value.additional_properties, null)
        }
      }
      dynamic "saml2_token" {
        for_each = try(optional_claims.value.saml2_token, null) != null ? [optional_claims.value.saml2_token] : []
        content {
          name                  = saml2_token.value.name
          source                = try(saml2_token.value.source, null)
          essential             = try(saml2_token.value.essential, null)
          additional_properties = try(saml2_token.value.additional_properties, null)
        }
      }
    }
  }
  owners = coalescelist(
    try(var.settings.owners, []),
    [
      var.client_config.object_id
    ]
  )
  privacy_statement_url = try(var.settings.privacy_statement_url, null)
  dynamic "public_client" {
    for_each = try(var.settings.public_client, null) != null ? [var.settings.public_client] : []
    content {
      redirect_uris = try(public_client.value.redirect_uris, null)
    }
  }
  dynamic "required_resource_access" {
    for_each = try(var.settings.required_resource_access, null) != null ? [var.settings.required_resource_access] : []
    content {
      resource_app_id = can(required_resource_access.value.resource_app.id) ? required_resource_access.value.resource_app.id : data.azuread_application_published_app_ids.well_known.result[required_resource_access.value.resource_app.well_known_key]
      dynamic "resource_access" {
        for_each = try(required_resource_access.value.resource_access, null) != null ? [required_resource_access.value.resource_access] : []
        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }
  sign_in_audience = can(var.settings.available_to_other_tenants) ? "AzureADMultipleOrgs" : try(var.settings.sign_in_audience, null)
  dynamic "single_page_application" {
    for_each = try(var.settings.single_page_application, null) != null ? [var.settings.single_page_application] : []
    content {
      redirect_uris = try(single_page_application.value.redirect_uris, null)
    }
  }
  support_url          = try(var.settings.support_url, null)
  tags                 = try(var.settings.tags, null)
  template_id          = try(var.settings.template.id, data.azuread_application_template.template.0.template_id, null)
  terms_of_service_url = try(var.settings.terms_of_service_url, null)
  dynamic "web" {
    for_each = try(var.settings.web, null) != null ? [var.settings.web] : []
    content {
      homepage_url  = try(web.value.homepage_url, null)
      logout_url    = try(web.value.logout_url, null)
      redirect_uris = try(web.value.redirect_uris, null)
      dynamic "implicit_grant" {
        for_each = try(web.value.implicit_grant, null) != null ? [web.value.implicit_grant] : []
        content {
          access_token_issuance_enabled = try(implicit_grant.value.access_token_issuance_enabled, null)
          id_token_issuance_enabled     = try(implicit_grant.value.id_token_issuance_enabled, null)
        }
      }
    }
  }
  prevent_duplicate_names = try(var.settings.prevent_duplicate_names, null)
}
