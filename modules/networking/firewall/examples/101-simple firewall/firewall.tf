provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_test" {
  name     = local.resource_groups.test.name
  location = local.resource_groups.test.location
  tags     = local.tags
}

module "la_test" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "2.0.0"

  convention          = local.convention
  location            = local.location
  name                = local.name
  solution_plan_map   = local.solution_plan_map
  prefix              = local.prefix
  resource_group_name = azurerm_resource_group.rg_test.name
  tags                = local.tags
}

module "diags_test" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "2.0.0"

  name                = local.name
  convention          = local.convention
  resource_group_name = azurerm_resource_group.rg_test.name
  prefix              = local.prefix
  location            = local.location
  tags                = local.tags
  enable_event_hub    = local.enable_event_hub
}

module "vnet_test" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "2.0.0"

  virtual_network_rg      = azurerm_resource_group.rg_test.name
  prefix                  = local.prefix
  location                = local.location
  networking_object       = local.vnet_config
  tags                    = local.tags
  diagnostics_map         = module.diags_test.diagnostics_map
  log_analytics_workspace = module.la_test
  diagnostics_settings    = local.vnet_config.diagnostics
  convention              = local.convention
}

module "public_ip_test" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "2.0.0"

  name                       = local.ip_addr_config.ip_name
  location                   = local.location
  rg                         = azurerm_resource_group.rg_test.name
  ip_addr                    = local.ip_addr_config
  tags                       = local.tags
  diagnostics_map            = module.diags_test.diagnostics_map
  log_analytics_workspace_id = module.la_test.id
  diagnostics_settings       = local.ip_addr_config.diagnostics
  convention                 = local.convention
}

module "firewall_test" {
  source = "../../"

  convention           = local.convention
  name                 = local.az_fw_config.name
  resource_group_name  = azurerm_resource_group.rg_test.name
  location             = local.location
  tags                 = local.tags
  la_workspace_id      = module.la_test.id
  diagnostics_map      = module.diags_test.diagnostics_map
  diagnostics_settings = local.az_fw_config.diagnostics

  subnet_id    = lookup(module.vnet_test.vnet_subnets, "AzureFirewallSubnet", null)
  public_ip_id = module.public_ip_test.id
}

