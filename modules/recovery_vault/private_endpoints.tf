

#
# Private endpoint
#

module private_endpoint {
  source   = "../networking/private_endpoint"
  depends_on = [null_resource.enable_asr_system_identity]

  for_each = try(var.private_endpoints, {})

  resource_id         = azurerm_recovery_services_vault.asr_rg_vault.id
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = local.tags
}
