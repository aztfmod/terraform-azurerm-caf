terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

locals {
  resource_group = coalesce(
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group_key], null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key], null),
    try(var.resource_groups[var.settings.lz_key][var.settings.resource_group_key], null),
    try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key], null)
  )

  storage_account = coalesce(
    try(var.storage_accounts[var.client_config.landingzone_key][var.settings.storage_account_key], null),
    try(var.storage_accounts[var.client_config.landingzone_key][var.settings.storage_account.key], null),
    try(var.storage_accounts[var.settings.lz_key][var.settings.storage_account_key], null),
    try(var.storage_accounts[var.settings.storage_account.lz_key][var.settings.storage_account.key], null)
  )

  app_service_plan = coalesce(
    try(var.app_service_plans[var.client_config.landingzone_key][var.settings.app_service_plan_key], null),
    try(var.app_service_plans[var.client_config.landingzone_key][var.settings.app_service_plan.key], null),
    try(var.app_service_plans[var.settings.lz_key][var.settings.app_service_plan_key], null),
    try(var.app_service_plans[var.settings.app_service_plan.lz_key][var.settings.app_service_plan.key], null)
  )
}