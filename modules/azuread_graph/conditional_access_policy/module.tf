 
resource "azuread_conditional_access_policy" "conap" {
  display_name = var.settings.display_name
  state = var.settings.state
  dynamic "conditions" {
    for_each = try(var.settings.conditions, null) != null ? [var.settings.conditions] : []
    content { 
      dynamic "applications" {
        for_each = try(conditions.value.applications, null) != null ? [conditions.value.applications] : []
        content { 
          included_applications = applications.value.included_applications
          excluded_applications = try(applications.value.excluded_applications, null)
          included_user_actions = try(applications.value.included_user_actions, null)
        }
      }
      dynamic "users" {
        for_each = try(conditions.value.users, null) != null ? [conditions.value.users] : []
        content { 
          included_users = try(users.value.included_users, null)
          excluded_users = try(users.value.excluded_users, null)
          included_groups = try(users.value.included_groups, null)
          excluded_groups = try(users.value.excluded_groups, null)
          included_roles = try(users.value.included_roles, null)
          excluded_roles = try(users.value.excluded_roles, null)
        }
      }
      client_app_types = conditions.value.client_app_types
      dynamic "devices" {
        for_each = try(conditions.value.devices, null) != null ? [conditions.value.devices] : []
        content { 
          dynamic "filter" {
            for_each = try(devices.value.filter, null) != null ? [devices.value.filter] : []
            content { 
              mode = filter.value.mode
              rule = filter.value.rule
            }
          }
        }
      }
      dynamic "locations" {
        for_each = try(conditions.value.locations, null) != null ? [conditions.value.locations] : []
        content { 
          included_locations = locations.value.included_locations
          excluded_locations = try(locations.value.excluded_locations, null)
        }
      }
      dynamic "platforms" {
        for_each = try(conditions.value.platforms, null) != null ? [conditions.value.platforms] : []
        content { 
          included_platforms = platforms.value.included_platforms
          excluded_platforms = try(platforms.value.excluded_platforms, null)
        }
      }
      sign_in_risk_levels = try(conditions.value.sign_in_risk_levels, null)
      user_risk_levels = try(conditions.value.user_risk_levels, null)
    }
  }
  dynamic "grant_controls" {
    for_each = try(var.settings.grant_controls, null) != null ? [var.settings.grant_controls] : []
    content { 
      operator = grant_controls.value.operator
      built_in_controls = grant_controls.value.built_in_controls
      custom_authentication_factors = try(grant_controls.value.custom_authentication_factors, null)
      terms_of_use = try(grant_controls.value.terms_of_use, null)
    }
  }
  dynamic "session_controls" {
    for_each = try(var.settings.session_controls, null) != null ? [var.settings.session_controls] : []
    content { 
      application_enforced_restrictions_enabled = try(session_controls.value.application_enforced_restrictions_enabled, null)
      cloud_app_security_policy = try(session_controls.value.cloud_app_security_policy, null)
      persistent_browser_mode = try(session_controls.value.persistent_browser_mode, null)
      sign_in_frequency = try(session_controls.value.sign_in_frequency, null)
      sign_in_frequency_period = try(session_controls.value.sign_in_frequency_period, null)
    }
  }
}
