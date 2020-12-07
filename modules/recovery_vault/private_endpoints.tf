

#
# Private endpoint
#

module private_endpoint {
  source     = "../networking/private_endpoint"
  depends_on = [azurerm_resource_group_template_deployment.asr]
  # depends_on = [null_resource.enable_asr_system_identity, time_sleep.delay_create]

  for_each = try(var.private_endpoints, {})

  resource_id         = local.asr_id
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  subnet_id           = try(each.value.lz_key, null) == null ? var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id : var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = local.tags
}
