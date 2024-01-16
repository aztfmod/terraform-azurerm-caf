resource "azurerm_dashboard_grafana" "dashboard" {
  name                                   = var.settings.name
  resource_group_name                    = local.resource_group_name
  location                               = local.location
  api_key_enabled                        = var.settings.api_key_enabled
  auto_generated_domain_name_label_scope = var.settings.auto_generated_domain_name_label_scope
  deterministic_outbound_ip_enabled      = var.settings.deterministic_outbound_ip_enabled
  public_network_access_enabled          = var.settings.public_network_access_enabled
  # grafana_major_version                  = var.settings.grafana_major_version
  sku                     = var.settings.sku
  zone_redundancy_enabled = var.settings.zone_redundancy_enabled

  dynamic "identity" {
    for_each = try(var.settings.identity, null) == null ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = lower(var.settings.identity.type) == "userassigned" ? can(var.settings.identity.user_assigned_identity_id) ? [var.settings.identity.user_assigned_identity_id] : [var.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.identity.managed_identity_key].id] : null
    }
  }

  dynamic "azure_monitor_workspace_integrations" {
    for_each = try(var.settings.azure_monitor_workspace_integrations, null) != null ? [var.settings.azure_monitor_workspace_integrations] : []

    content {
      resource_id = each.value.id
    }
  }

  tags = local.tags
}
