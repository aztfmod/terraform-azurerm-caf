module "caf" {
  source                    = "../../../../"
  global_settings           = var.global_settings
  tags                      = var.tags
  resource_groups           = var.resource_groups
  storage_accounts          = var.storage_accounts
  event_hubs                = var.event_hubs
  event_hub_auth_rules      = var.event_hub_auth_rules
  event_hub_namespaces      = var.event_hub_namespaces
  event_hub_consumer_groups = var.event_hub_consumer_groups
}

