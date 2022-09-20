module "namespace_auth_rules" {
  source   = "./namespace_auth_rule"
  for_each = try(var.settings.namespace_auth_rules, {})

  global_settings = var.global_settings
  client_config   = var.client_config
  settings        = each.value

  remote_objects = {
    servicebus_namespace_id = azurerm_servicebus_namespace.namespace.id
    resource_group_name     = local.resource_group_name
  }

}