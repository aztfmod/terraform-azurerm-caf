
module "subscriptions" {
  source = "./modules/subscriptions"

  for_each = var.subscriptions

  global_settings  = local.global_settings
  subscription_key = each.key
  settings         = each.value
  # billing_scope_id can also be set by tfvars (var.settings). This is only the way to inject billing_scope_id by key
  billing_scope_id = can(each.value.invoice_section_key) ? local.combined_objects_invoice_sections[try(each.value.invoice_section_lz_key, local.client_config.landingzone_key)][each.value.invoice_section_key].id : null
  client_config    = local.client_config
  diagnostics      = local.combined_diagnostics
  tags             = merge(var.tags, lookup(each.value, "tags", {}))
}


module "subscription_billing_role_assignments" {
  source   = "./modules/subscription_billing_role_assignment"
  for_each = var.subscription_billing_role_assignments

  billing_role_definition_name = each.value.billing_role_definition_name
  client_config                = local.client_config
  cloud                        = local.cloud
  keyvaults                    = local.combined_objects_keyvaults
  settings                     = each.value
  principals = {
    azuread_users              = local.combined_objects_azuread_users
    managed_identities         = local.combined_objects_managed_identities
    azuread_service_principals = local.combined_objects_azuread_service_principals
  }
}

output "subscriptions" {
  value = module.subscriptions
}

