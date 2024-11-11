module "cognitive_services_account" {
  source              = "./modules/cognitive_services/cognitive_services_account"
  for_each            = local.cognitive_services.cognitive_services_account
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  location            = try(each.value.location, null)
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  private_endpoints   = try(each.value.private_endpoints, {})

  remote_objects = {
    # Depurar en algún moment para pasar la logica de la subnet_id a remote_objects, error: The given key does not identify an element in this collection value.
    #subnet_id = can(each.value.network_acls.virtual_network_rules.subnet_key) ? local.combined_objects_networking[try(each.value.network_acls.virtual_network_rules.lz_key, local.client_config.landingzone_key)][each.value.network_acls.virtual_network_rules.vnet_key].subnets[each.value.network_acls.virtual_network_rules.subnet_key].id : null
    #subnet_id           = can(each.value.vnet.subnet_key) ? local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id : null
    vnets               = local.combined_objects_networking
    virtual_subnets     = local.combined_objects_virtual_subnets
    private_dns_zone_id = can(each.value.private_dns_zone.key) ? local.combined_objects_private_dns[try(each.value.private_dns_zone.lz_key, local.client_config.landingzone_key)][each.value.private_dns_zone.key].id : null
    diagnostics         = local.combined_diagnostics
    resource_groups     = local.combined_objects_resource_groups
    private_dns         = local.combined_objects_private_dns
  }
}


output "cognitive_services_account" {
  value = module.cognitive_services_account
}

module "cognitive_account_customer_managed_key" {
  source               = "./modules/cognitive_services/cognitive_account_customer_managed_key"
  for_each             = local.cognitive_services.cognitive_account_customer_managed_key
  cognitive_account_id = can(each.value.cognitive_account_id) || can(each.value.cognitive_account.id) ? try(each.value.cognitive_account_id, each.value.cognitive_account.id) : local.combined_objects_cognitive_services_accounts[try(each.value.cognitive_account.lz_key, local.client_config.landingzone_key)][try(each.value.cognitive_account_key, each.value.cognitive_account_key.key)].id
  key_vault_key_id     = can(each.value.key_vault_key_id) || can(each.value.key_vault_key.id) ? try(each.value.key_vault_key_id, each.value.key_vault_key.id) : local.combined_objects_keyvault_keys[try(each.value.keyvault_key.lz_key, local.client_config.landingzone_key)][try(each.value.key_vault_key_key, each.value.key_vault_key.key)].id
  identity_client_id   = try(can(each.value.identity_client_id) || can(each.value.identity_client.id) ? try(each.value.identity_client_id, each.value.identity_client.id) : local.combined_objects_managed_identities[try(each.value.identity_client.lz_key, local.client_config.landingzone_key)][try(each.value.identity_client_key, each.value.identity_client.key)].id, null)


}

output "cognitive_account_customer_managed_key" {
  value = module.cognitive_account_customer_managed_key
}

module "cognitive_deployment" {
  source               = "./modules/cognitive_services/cognitive_deployment"
  for_each             = local.cognitive_services.cognitive_deployment
  settings             = each.value
  cognitive_account_id = can(each.value.cognitive_account_id) || can(each.value.cognitive_account.id) ? try(each.value.cognitive_account_id, each.value.cognitive_account.id) : local.combined_objects_cognitive_services_accounts[try(each.value.cognitive_account.lz_key, local.client_config.landingzone_key)][try(each.value.cognitive_account_key, each.value.cognitive_account_key.key)].id
}

output "cognitive_deployment" {
  value = module.cognitive_deployment
}