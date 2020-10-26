## TO BE REFACTORED

locals {
  checkifconfigpresent = lookup(var.nw_config, "create", {}) != {} ? true : false
  checkifcreateconfig  = lookup(var.nw_config, "create", {}) != {} ? var.nw_config.create : false
  nsg                  = local.checkifconfigpresent == true ? var.nsg : {}
}

resource "azurerm_network_watcher" "netwatcher" {
  count = local.checkifcreateconfig && local.checkifconfigpresent ? 1 : 0

  name                = var.nw_config.name
  location            = var.location
  resource_group_name = var.rg
  tags                = local.tags
}

resource "azurerm_network_watcher_flow_log" "nw_flow" {

  for_each = local.nsg

  # if we havent created the azurerm_network_watcher.netwatcher
  # then we take the value given (optional)
  network_watcher_name = local.checkifcreateconfig ? azurerm_network_watcher.netwatcher[0].name : var.netwatcher.name
  resource_group_name  = local.checkifcreateconfig ? var.rg : var.netwatcher.rg

  network_security_group_id = each.value.id
  storage_account_id        = var.diagnostics_map.diags_sa
  enabled                   = lookup(var.nw_config, "flow_logs_settings", {}) != {} ? var.nw_config.flow_logs_settings.enabled : false

  retention_policy {
    enabled = lookup(var.nw_config, "flow_logs_settings", {}) != {} ? var.nw_config.flow_logs_settings.retention : false
    days    = lookup(var.nw_config, "flow_logs_settings", {}) != {} ? var.nw_config.flow_logs_settings.period : 7
  }

  traffic_analytics {
    enabled               = lookup(var.nw_config, "traffic_analytics_settings", {}) != {} ? var.nw_config.traffic_analytics_settings.enabled : false
    workspace_id          = var.log_analytics_workspace.object.workspace_id
    workspace_region      = var.log_analytics_workspace.object.location
    workspace_resource_id = var.log_analytics_workspace.object.id
  }
}



