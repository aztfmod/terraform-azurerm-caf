module "caf" {
  source             = "../../../../../"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  managed_identities = var.managed_identities
  keyvaults          = var.keyvaults
  role_mapping       = var.role_mapping

  diagnostics = {
    # Get the diagnostics settings of services to create
    diagnostic_log_analytics = var.diagnostic_log_analytics
  }

  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
  }

  security = {
    dynamic_keyvault_secrets = var.dynamic_keyvault_secrets
  }

  # compute = {
  #   container_groups = var.container_groups
  # }

}

