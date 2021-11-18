locals {
  endpoint_collection = flatten([
    for endpoint_key, endpoint in var.endpoints : {
      endpoint_name          = endpoint.name
      endpoint_key           = endpoint_key
      endpoint_profile_name  = endpoint.profile_name
      origin_name            = endpoint.origin_name
      delivery_rule_name     = try(endpoint.delivery_rule_name, "HttpsRedirect")
      delivery_order         = try(endpoint.delivery_order, 1)
      delivery_match_value   = try(endpoint.delivery_match_value, "HTTP")
      delivery_operator      = try(endpoint.delivery_operator, "Equal")
      delivery_redirect_type = try(endpoint.delivery_redirect_type, "Found")
      delivery_protocol      = try(endpoint.delivery_protocol, "Https")
      storage_host_name      = try(var.storage_accounts[try(endpoint.lz_key, var.client_config.landingzone_key)][endpoint.storage_account_key].primary_web_host, null)
    }
  ])

  endpoint_collection_map = {
    for endpoint in local.endpoint_collection :
    "${endpoint.endpoint_key}" => endpoint
    if var.settings.name == endpoint.endpoint_profile_name
  }
}