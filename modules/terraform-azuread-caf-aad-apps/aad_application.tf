#
# AAD Applications
#

locals {
  # check structure, add missing fields
  aad_apps_all_attributes = {
    for key, aad_app in var.aad_apps : key => merge(var.aad_app, aad_app)
  }

  aad_apps_to_create = {
    for aad_application in
    flatten(
      [
        for key, aad_app in local.aad_apps_all_attributes : {
          aad_app_key             = key
          convention              = lookup(aad_app, "convention", "cafrandom")
          useprefix               = lookup(aad_app, "useprefix", true)
          application_name        = lookup(aad_app, "application_name", null)
          password_expire_in_days = lookup(aad_app, "password_expire_in_days", 90)
          tenant_name             = lookup(aad_app, "keyvault", data.azurerm_client_config.current.tenant_id)
          keyvault                = lookup(aad_app, "keyvault", {})
        } if lookup(aad_app, "app_application_id", null) == null
      ]
    ) : aad_application.aad_app_key => aad_application
  }
}

resource "azurecaf_naming_convention" "aad_apps" {
  for_each = local.aad_apps_to_create

  name          = each.value.application_name
  resource_type = "rg" # workaround until support for aad apps
  convention    = each.value.convention
  prefix        = each.value.useprefix ? var.prefix : null
}

resource "azuread_application" "aad_apps" {
  for_each = {
    for key, app in local.aad_apps_to_create : key => app
  }

  name = azurecaf_naming_convention.aad_apps[each.key].result

  owners = [
    data.azurerm_client_config.current.object_id
  ]

  reply_urls = lookup(each.value, "reply_urls", null)

  dynamic "required_resource_access" {
    for_each = {
      for key, permission in lookup(var.aad_api_permissions, each.key, []) : key => permission
    }

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

  lifecycle {
    ignore_changes = [
      owners
    ]
  }
}

resource "azuread_service_principal" "aad_apps" {
  for_each = local.aad_apps_to_create

  application_id = azuread_application.aad_apps[each.key].application_id
}

resource "azuread_service_principal_password" "aad_apps" {
  for_each = local.aad_apps_to_create

  service_principal_id = azuread_service_principal.aad_apps[each.key].id
  value                = random_password.aad_apps.result
  end_date_relative    = format("%sh", each.value.password_expire_in_days * 24)

  lifecycle {
    ignore_changes = [
      end_date_relative, value
    ]
  }
}

resource "random_password" "aad_apps" {
  length  = 250
  special = false
  upper   = true
  number  = true
}
