
module "nsg_flows" {
  source = "../virtual_network/nsg/flow_logs"
  count  = try(var.settings.version, 0) > 0 && try(var.settings.flow_logs, null) != null ? 1 : 0

  resource_id       = azurerm_network_security_group.nsg.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  settings          = var.settings.flow_logs
  network_watchers  = var.network_watchers
  client_config     = var.client_config
}
