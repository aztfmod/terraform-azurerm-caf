module "launchpad" {
  source = "/tf/caf"

  tags = local.tags
  global_settings                   = local.global_settings
  log_analytics                     = var.log_analytics
  diagnostics_definition            = var.diagnostics_definition
  diagnostics_destinations          = var.diagnostics_destinations
  resource_groups                   = var.resource_groups
  keyvaults                         = var.keyvaults
  subscriptions                     = var.subscriptions
  networking                        = var.networking
  network_security_group_definition = var.network_security_group_definition
  storage_accounts                  = var.storage_accounts

}
