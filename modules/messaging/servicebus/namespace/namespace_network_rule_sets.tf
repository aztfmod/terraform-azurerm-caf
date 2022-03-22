module "network_rule_sets" {
  source   = "./network_rule_set"
  for_each = try(var.settings.network_rule_sets, {})

  global_settings = var.global_settings
  client_config   = var.client_config
  settings        = each.value

  remote_objects = {
    servicebus_namespace_id = azurerm_servicebus_namespace.namespace.id
    resource_group_name     = local.resource_group_name
    vnets                   = var.remote_objects.vnets
  }

}