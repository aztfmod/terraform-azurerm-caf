locals {

  global_settings = {
    prefix             = local.prefix
    prefix_with_hyphen = local.prefix == "" ? "" : "${local.prefix}-"
    prefix_start_alpha = local.prefix == "" ? "" : "${random_string.alpha1.result}${local.prefix}"
    default_region     = lookup(var.global_settings, "default_region", "region1")
    environment        = lookup(var.global_settings, "environment", var.environment)
    random_length      = try(var.global_settings.random_length, 0)
    regions            = var.global_settings.regions
    passthrough        = try(var.global_settings.passthrough, false)
    inherit_tags       = try(var.global_settings.inherit_tags, false)
    use_slug           = try(var.global_settings.use_slug, true)
  }

  client_config = {
    client_id               = data.azurerm_client_config.current.client_id
    tenant_id               = var.tenant_id == null ? data.azurerm_client_config.current.tenant_id : var.tenant_id
    subscription_id         = data.azurerm_client_config.current.subscription_id
    object_id               = local.object_id
    logged_aad_app_objectId = local.object_id
    logged_user_objectId    = local.object_id
    # logged_aad_app_objectId = var.logged_aad_app_objectId == null ? var.logged_user_objectId == null ? data.azuread_service_principal.logged_in_app.0.object_id : var.logged_user_objectId : var.logged_aad_app_objectId
    # logged_user_objectId    = var.logged_user_objectId == null ? var.logged_aad_app_objectId == null ? data.azuread_service_principal.logged_in_app.0.object_id : var.logged_aad_app_objectId : var.logged_user_objectId
    landingzone_key = var.current_landingzone_key
  }


  shared_services = {
    recovery_vaults      = try(var.shared_services.recovery_vaults, {})
    automations          = try(var.shared_services.automations, {})
    monitoring           = try(var.shared_services.monitoring, {})
    shared_image_gallery = try(var.shared_services.shared_image_gallery, {})
    packer               = try(var.shared_services.packer, {})
  }


}