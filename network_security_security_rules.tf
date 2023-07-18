module "network_security_security_rules" {
  source = "./modules/networking/network_security_security_rules"

  for_each = local.networking.network_security_security_rules

  direction       = each.key
  client_config   = local.client_config
  global_settings = local.global_settings
  settings        = each.value

  remote_objects = {
    application_security_groups = local.combined_objects_application_security_groups
    network_security_groups     = local.combined_objects_network_security_groups
    vnets                       = local.combined_objects_networking,
    virtual_subnets             = local.combined_objects_virtual_subnets
  }
}

output "network_security_security_rules" {
  value = module.network_security_security_rules
}