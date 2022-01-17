module "subnet" {
  source   = "./subnet"
  for_each = toset(try(var.settings.subnet_keys, []))

  global_settings          = var.global_settings
  client_config            = var.client_config
  resource_groups          = var.resource_groups
  private_endpoints        = var.settings
  private_dns              = var.private_dns
  vnet_resource_group_name = var.vnet.resource_group_name
  vnet_location            = var.vnet.location
  subnet_id                = var.vnet.subnets[each.key].id
  remote_objects           = var.remote_objects
  base_tags                = var.base_tags
}

output "subnet" {
  value = module.subnet
}
