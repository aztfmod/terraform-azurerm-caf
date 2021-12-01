
resource "azurecaf_name" "adds" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_active_directory_domain_service"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_active_directory_domain_service" "adds" {
  name                  = azurecaf_name.adds.result
  resource_group_name   = var.resource_group_name
  location              = var.remote_objects.location
  domain_name           = var.settings.domain_name
  filtered_sync_enabled = try(var.settings.filtered_sync_enabled, null)
  sku                   = var.settings.sku
  tags                  = local.tags

  dynamic "secure_ldap" {
    for_each = try(var.settings.secure_ldap, null) != null ? [var.settings.secure_ldap] : []
    content {
      enabled                  = try(secure_ldap.value.enabled, null)
      external_access_enabled  = try(secure_ldap.value.external_access_enabled, null)
      pfx_certificate          = try(secure_ldap.value.pfx_certificate, null)
      pfx_certificate_password = try(secure_ldap.value.pfx_certificate_password, null)
    }
  }

  dynamic "notifications" {
    for_each = try(var.settings.notifications, null) != null ? [var.settings.notifications] : []
    content {
      additional_recipients = try(notifications.value.additional_recipients, null)
      notify_dc_admins      = try(notifications.value.notify_dc_admins, null)
      notify_global_admins  = try(notifications.value.notify_global_admins, null)
    }
  }

  dynamic "initial_replica_set" {
    for_each = try(var.settings.initial_replica_set, null) != null ? [var.settings.initial_replica_set] : []
    content {
      subnet_id = coalesce(
        try(var.remote_objects.vnets[initial_replica_set.value.subnet.lz_key][initial_replica_set.value.subnet.vnet_key].subnets[initial_replica_set.value.subnet.key].id, null),
        try(var.remote_objects.vnets[var.client_config.landingzone_key][initial_replica_set.value.subnet.vnet_key].subnets[initial_replica_set.value.subnet.key].id, null),
        try(initial_replica_set.subnet.value.subnet_id, null)
      )
    }
  }

  dynamic "security" {
    for_each = try(var.settings.security, null) != null ? [var.settings.security] : []
    content {
      ntlm_v1_enabled         = try(security.value.ntlm_v1_enabled, null)
      sync_kerberos_passwords = try(security.value.sync_kerberos_passwords, null)
      sync_ntlm_passwords     = try(security.value.sync_ntlm_passwords, null)
      sync_on_prem_passwords  = try(security.value.sync_on_prem_passwords, null)
      tls_v1_enabled          = try(security.value.tls_v1_enabled, null)
    }
  }
}
