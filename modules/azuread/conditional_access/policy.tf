

resource "azuread_conditional_access_policy" "conditional_access_policy" {

  display_name = var.name
  state        = var.state

  dynamic "conditions" {
    for_each = try(var.conditions, null) != null ? [var.conditions]: []
    content {
      client_app_types = try(conditions.value.client_app_types, ["all"])
      sign_in_risk_levels = try(conditions.value.sign_in_risk_levels, [])
      user_risk_levels = try(conditions.value.user_risk_levels, [])

      dynamic "applications" {
        for_each = try(conditions.value.applications, null) == null ? [] : [conditions.value.devices]
        content {
          excluded_applications = try(applications.value.excluded_applications , null)
          included_applications = try(applications.value.included_applications , null)
          included_user_actions = try(applications.value.included_user_actions , [])
        }
      }

      dynamic "devices" {
        for_each = try(conditions.value.devices, null) == null ? [] : [conditions.value.devices]
        content {
          filter {
            mode = devices.value.filter.mode
            rule = devices.value.filter.rule
          }
        }
      }

      dynamic "locations" {
        for_each = try(conditions.value.locations, null) == null ? [] : [conditions.value.locations]
        content {
          excluded_locations = try(locations.value.excluded_locations, [])
          included_locations = locations.value.included_locations
        }
      }

      dynamic "users" {
        for_each = try(conditions.value.users, null) == null ? [] : [conditions.value.users]
        content {
          excluded_groups = try(local.excluded_groups, [])
          excluded_roles = try(users.value.excluded_roles, [])
          excluded_users = try(local.excluded_users, [])
          included_groups = try(local.included_groups, [])
          included_roles = try(users.value.included_roles, [])
          included_users = try(local.included_users, [])
        }
      }

      dynamic "platforms" {
        for_each = try(conditions.value.platforms, null) == null ? [] : [conditions.value.platforms]
        content {
          excluded_platforms = try(platforms.value.excluded_platforms,[])
          included_platforms = platforms.value.included_platforms
        }
      }
    }
  }

  dynamic "grant_controls" {
    for_each = try(var.grant_controls, null) == null ? []: [var.grant_controls]
    content {
      built_in_controls             = grant_controls.value.built_in_controls
      custom_authentication_factors = try(grant_controls.value.custom_authentication_factors , [])
      operator                      = grant_controls.value.operator
      terms_of_use                  = try(grant_controls.value.terms_of_use , [])
    }
  }

  dynamic "session_controls" {
    for_each = try(var.session_controls, null) == null ? [] : [var.session_controls]

    content {
      application_enforced_restrictions_enabled = try(session_controls.value.application_enforced_restrictions_enabled, false)
      cloud_app_security_policy                 = try(session_controls.value.cloud_app_security_policy ,null)
      persistent_browser_mode                   = try(session_controls.value.persistent_browser_mode ,null)
      sign_in_frequency                         = try(session_controls.value.sign_in_frequency ,null)
      sign_in_frequency_period                  = try(session_controls.value.sign_in_frequency_period ,null)
    }
  }
}