locals {
  endpoint_collection = flatten([
    for endpoint_key, endpoint in var.settings.endpoints : {
      endpoint_name     = endpoint.name
      storage_host_name = var.storage_accounts[try(endpoint.lz_key, var.client_config.landingzone_key)][endpoint.storage_account_key].primary_web_host
    }
  ])

  endpoint_collection_map = {
    for endpoint in local.endpoint_collection :
    "${endpoint.profile_key}.${endpoint.endpoint_key}" => endpoint
  }
}