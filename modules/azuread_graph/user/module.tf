
locals {
  global_settings = {
    prefixes      = lookup(var.settings, "useprefix", null) == true ? try(var.settings.global_settings.prefixes, var.global_settings.prefixes) : []
    random_length = try(var.settings.global_settings.random_length, var.global_settings.random_length)
    passthrough   = try(var.settings.global_settings.passthrough, var.global_settings.passthrough)
    use_slug      = try(var.settings.global_settings.use_slug, var.global_settings.use_slug)
  }

  password_policy = try(var.settings.password_policy, var.password_policy)
  user_name       = var.settings.user_name
  tenant_name     = lookup(var.settings, "tenant_name", data.azuread_domains.aad_domains.domains[0].domain_name)
  keyvault_id     = var.remote_objects.keyvaults[try(var.settings.keyvault.lz_key, var.client_config.landingzone_key)][try(var.settings.keyvault.key, var.settings.keyvault_key)].id
  secret_prefix   = lookup(var.settings, "secret_prefix", "")
}

data "azuread_domains" "aad_domains" {
  only_initial = true
}

resource "azurecaf_name" "account" {
  name          = local.user_name
  resource_type = "general"
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug

  lifecycle {
    ignore_changes = [resource_type]
    #to preserve resource created in previous versions
  }
}

resource "azuread_user" "account" {
  account_enabled             = try(var.settings.account_enabled, null)
  age_group                   = try(var.settings.age_group, "")
  business_phones             = try(var.settings.business_phones, null)
  city                        = try(var.settings.city, "")
  company_name                = try(var.settings.company_name, "")
  consent_provided_for_minor  = try(var.settings.consent_provided_for_minor, "")
  cost_center                 = try(var.settings.cost_center, null)
  country                     = try(var.settings.country, "")
  department                  = try(var.settings.department, "")
  disable_password_expiration = try(var.settings.disable_password_expiration, null)
  disable_strong_password     = try(var.settings.disable_strong_password, null)
  display_name                = can(var.settings.display_name) ? var.settings.display_name : azurecaf_name.account.result
  division                    = try(var.settings.division, null)
  employee_id                 = try(var.settings.employee_id, "")
  employee_type               = try(var.settings.employee_type, null)
  fax_number                  = try(var.settings.fax_number, "")
  force_password_change       = try(var.settings.force_password_change, null)
  given_name                  = try(var.settings.given_name, "")
  job_title                   = try(var.settings.job_title, "")
  mail                        = try(var.settings.mail, "")
  mail_nickname               = try(var.settings.mail_nickname, null)
  manager_id                  = try(var.settings.manager_id, "")
  mobile_phone                = try(var.settings.mobile_phone, "")
  office_location             = try(var.settings.office_location, "")
  onpremises_immutable_id     = try(var.settings.onpremises_immutable_id, "")
  other_mails                 = try(var.settings.other_mails, null)
  password                    = try(var.settings.password, null)
  postal_code                 = try(var.settings.postal_code, "")
  preferred_language          = try(var.settings.preferred_language, null)
  show_in_address_list        = try(var.settings.show_in_address_list, null)
  state                       = try(var.settings.state, "")
  street_address              = try(var.settings.street_address, "")
  surname                     = try(var.settings.surname, "")
  usage_location              = try(var.settings.usage_location, "")
  user_principal_name         = can(var.settings.user_principal_name) ? var.settings.user_principal_name : format("%s@%s", azurecaf_name.account.result, local.tenant_name)

}

resource "time_rotating" "pwd" {
  rotation_minutes = try(local.password_policy.rotation.mins, null)
  rotation_days    = try(local.password_policy.rotation.days, null)
  rotation_months  = try(local.password_policy.rotation.months, null)
  rotation_years   = try(local.password_policy.rotation.years, null)
}

# Will force the password to change every month
resource "random_password" "pwd" {
  keepers = {
    frequency = time_rotating.pwd.id
  }
  length  = local.password_policy.length
  special = local.password_policy.special
  upper   = local.password_policy.upper
  numeric = local.password_policy.number
}

resource "azurerm_key_vault_secret" "aad_user_name" {
  name         = format("%s%s-name", local.secret_prefix, local.user_name)
  value        = azuread_user.account.user_principal_name
  key_vault_id = local.keyvault_id
}

resource "azurerm_key_vault_secret" "aad_user_password" {
  name            = format("%s%s-password", local.secret_prefix, local.user_name)
  value           = random_password.pwd.result
  expiration_date = timeadd(time_rotating.pwd.id, format("%sh", local.password_policy.expire_in_days * 24))
  key_vault_id    = local.keyvault_id
}