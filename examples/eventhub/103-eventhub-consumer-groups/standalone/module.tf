module "caf" {
  source = "../../../../"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  storage_accounts  = var.storage_accounts
  event_hub         = var.event_hub
  event_hub_auth_rules = var.event_hub_auth_rules
  event_hub_namespaces = var.event_hub_namespaces
}
  
