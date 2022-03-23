locals {
  remote_objects = {
    managed_identities  = merge(tomap({ (local.client_config.landingzone_key) = module.managed_identities }), try(var.remote_objects.managed_identities, {}))
    azuread_graph_group = merge(tomap({ (local.client_config.landingzone_key) = module.azuread_graph_group }), try(var.remote_objects.azuread_groups, {}))
  }
}
