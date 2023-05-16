# create private DNS if container app env is using internal networking
# https://learn.microsoft.com/en-us/azure/container-apps/networking#dns
module "private_dns" {
  source = "../../networking/private-dns"
  count  = try(var.settings.vnet.vnet_key, null) != null && try(var.settings.vnet.internal, false) ? 1 : 0

  global_settings     = var.global_settings
  client_config       = var.client_config
  name                = jsondecode(azapi_resource.container_app_env.output).properties.defaultDomain
  resource_group_name = local.resource_group.name
  base_tags           = false
  # cannot use this approach to create wildcard record, see note below
  records = {
    # a_records = {
    #   wildcard = {
    #     name = "*"
    #     ttl  = 3600
    #     records = [
    #       jsondecode(azapi_resource.container_app_env.output).properties.staticIp
    #     ]
    #   }
    # }
  }
  vnet_links = {
    cae-vnet-link = {
      name     = "cae-vnet-link"
      lz_key   = var.settings.vnet.lz_key
      vnet_key = var.settings.vnet.vnet_key
    }
  }
  tags  = local.tags
  vnets = var.vnets
}

# would prefer to pass this into private_dns module, but terraform for_each cannot be done with map keys
# that are derived from resource attributes
resource "azurerm_private_dns_a_record" "wildcard" {
  count = try(var.settings.vnet.vnet_key, null) != null && try(var.settings.vnet.internal, false) ? 1 : 0
  depends_on = [
    module.private_dns
  ]

  name                = "*"
  zone_name           = jsondecode(azapi_resource.container_app_env.output).properties.defaultDomain
  resource_group_name = local.resource_group.name
  ttl                 = 3600
  records             = [jsondecode(azapi_resource.container_app_env.output).properties.staticIp]
  tags                = local.tags
}
