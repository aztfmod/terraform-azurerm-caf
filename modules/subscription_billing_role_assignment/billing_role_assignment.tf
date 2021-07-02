data "azurerm_billing_enrollment_account_scope" "sub" {
  billing_account_name    = var.settings.billing_account_name
  enrollment_account_name = var.settings.enrollment_account_name
}

data "external" "role_definition" {
  program = [
    "bash", "-c",
    "az rest --method GET --url ${var.cloud.resourceManager}${local.billing_scope_id}/billingRoleDefinitions?api-version=2019-10-01-preview --query \"value[?properties.roleName=='${var.billing_role_definition_name}'].{id:id}[0]\" -o json"
  ]

  #
  # az rest --method GET \
  #   --url https://management.azure.com${data.azurerm_billing_enrollment_account_scope.sub.id}/billingRoleDefinitions?api-version=2019-10-01-preview \
  #   --query "value[?properties.roleName=='${var.billing_role_definition_name}'].{id:id}[0]" -o json

}

locals {
  billing_scope_id = data.azurerm_billing_enrollment_account_scope.sub.id
}

module "role_assignment_azuread_users" {
  source   = "./role_assignment"
  for_each = try(var.settings.principals.azuread_users, {})

  billing_scope_id   = local.billing_scope_id
  tenant_id          = try(var.principals.azuread_users[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].tenant_id, var.client_config.tenant_id)
  principal_id       = var.principals.azuread_users[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].rbac_id
  role_definition_id = data.external.role_definition.result.id
  settings           = each.value
  cloud              = var.cloud
}


module "role_assignment_msi" {
  source     = "./role_assignment"
  for_each   = try(var.settings.principals.managed_identities, {})
  depends_on = [module.role_assignment_azuread_users]

  aad_user_impersonate = try(var.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][var.settings.aad_user_impersonate.keyvault.key], null)
  billing_scope_id     = local.billing_scope_id
  tenant_id            = try(var.principals.managed_identities[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].tenant_id, var.client_config.tenant_id)
  principal_id         = var.principals.managed_identities[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].principal_id
  role_definition_id   = data.external.role_definition.result.id
  settings             = each.value
  cloud                = var.cloud
}


module "role_assignment_azuread_service_principals" {
  source     = "./role_assignment"
  for_each   = try(var.settings.principals.azuread_service_principals, {})
  depends_on = [module.role_assignment_azuread_users, module.role_assignment_msi]

  aad_user_impersonate = try(var.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][var.settings.aad_user_impersonate.keyvault.key], null)
  billing_scope_id     = local.billing_scope_id
  tenant_id            = try(var.principals.azuread_service_principals[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].tenant_id, var.client_config.tenant_id)
  principal_id         = var.principals.azuread_service_principals[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].object_id
  role_definition_id   = data.external.role_definition.result.id
  settings             = each.value
  cloud                = var.cloud
}

