# Last review :  AzureRM version 2.95.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix

resource "azurerm_public_ip_prefix" "pip_prefix" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix_length       = var.prefix_length
  tags                = local.tags
  sku                 = var.sku
  availability_zone   = var.zones
  ip_version          = var.ip_version

}

/*

resource "null_resource" "set_initial_state" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "echo \"0\" > current_state.txt"
  }
}


resource "azurerm_public_ip" "pip" {
  #count = var.create_pips ? local.number_of_ips : 0

  public_ip_prefix_id     = azurerm_public_ip_prefix.pip_prefix.id
  name                    = "${self.ip_address}" 
  location                = local.pip.location
  allocation_method       = "Static"
  sku                     = "Standard"
  resource_group_name     = local.pip.resource_group_name
  idle_timeout_in_minutes = local.pip.idle_timeout_in_minutes
  domain_name_label       = try(tostring(element(concat(local.pip.domain_name_label, count.index), 0)), null)
  reverse_fqdn            = try(tostring(element(concat(local.pip.reverse_fqdn, count.index), 0)), null)
  tags                    = local.pip.tags
  ip_tags                 = local.pip.ip_tags

}



#
#
# Public IP Addresses
#
#

# naming convention for public IP address
resource "azurecaf_name" "public_ip_addresses" {
  for_each = local.networking.public_ip_addresses

  name          = try(each.value.name, null)
  resource_type = "azurerm_public_ip"
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

module "public_ip_addresses" {
  source   = "./modules/networking/public_ip_addresses"
  for_each = local.networking.public_ip_addresses

  name                       = self.ip_address
  resource_group_name        = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  location                   = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  sku                        = try(each.value.sku, "Basic")
  allocation_method          = try(each.value.allocation_method, "Dynamic")
  ip_version                 = try(each.value.ip_version, "IPv4")
  idle_timeout_in_minutes    = try(each.value.idle_timeout_in_minutes, null)
  domain_name_label          = try(each.value.domain_name_label, null)
  reverse_fqdn               = try(each.value.reverse_fqdn, null)
  generate_domain_name_label = try(each.value.generate_domain_name_label, false)
  tags                       = try(each.value.tags, null)
  ip_tags                    = try(each.value.ip_tags, null)
  public_ip_prefix_id        = try(each.value.public_ip_prefix_id, local.combined_objects_public_ip_prefixes[try(each.value.public_ip_prefix.lz_key, local.client_config.landingzone_key)][each.value.public_ip_prefix.key].id, null)  
  zones = coalesce(
    try(each.value.availability_zone, ""),
    try(tostring(each.value.zones[0]), ""),
    try(each.value.sku, "Basic") == "Basic" ? "No-Zone" : "Zone-Redundant"
  )
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}

  
}

*/