module "lb" {
  source   = "./modules/networking/lb"
  for_each = local.networking.lb

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  location = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  # if resource_group.name is defined and not null, use that.  if resource_group_name is defined and not null, use that.  otherwise calculate name using combined_objects_resource_groups
  resource_group_name = try(each.value.resource_group.name, null) != null ? each.value.resource_group.name : try(each.value.resource_group_name, null) != null ? each.value.resource_group_name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    resource_group      = local.combined_objects_resource_groups
    virtual_network     = local.combined_objects_networking
    public_ip_addresses = local.combined_objects_public_ip_addresses
  }
}
output "lb" {
  value = module.lb
}

module "lb_backend_address_pool" {
  source   = "./modules/networking/lb_backend_address_pool"
  for_each = local.networking.lb_backend_address_pool

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value


  remote_objects = {
    lb = local.combined_objects_lb
  }
}
output "lb_backend_address_pool" {
  value = module.lb_backend_address_pool
}

module "lb_backend_address_pool_address" {
  source   = "./modules/networking/lb_backend_address_pool_address"
  for_each = local.networking.lb_backend_address_pool_address

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    virtual_network         = local.combined_objects_networking
    lb_backend_address_pool = local.combined_objects_lb_backend_address_pool
  }
}
output "lb_backend_address_pool_address" {
  value = module.lb_backend_address_pool_address
}

module "lb_nat_pool" {
  source   = "./modules/networking/lb_nat_pool"
  for_each = local.networking.lb_nat_pool

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  # if resource_group.name is defined and not null, use that.  if resource_group_name is defined and not null, use that.  otherwise calculate name using combined_objects_resource_groups
  resource_group_name = try(each.value.resource_group.name, null) != null ? each.value.resource_group.name : try(each.value.resource_group_name, null) != null ? each.value.resource_group_name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    resource_group = local.combined_objects_resource_groups
    lb             = local.combined_objects_lb
  }
}
output "lb_nat_pool" {
  value = module.lb_nat_pool
}
module "lb_nat_rule" {
  source   = "./modules/networking/lb_nat_rule"
  for_each = local.networking.lb_nat_rule

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  # if resource_group.name is defined and not null, use that.  if resource_group_name is defined and not null, use that.  otherwise calculate name using combined_objects_resource_groups
  resource_group_name = try(each.value.resource_group.name, null) != null ? each.value.resource_group.name : try(each.value.resource_group_name, null) != null ? each.value.resource_group_name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    resource_group = local.combined_objects_resource_groups
    lb             = local.combined_objects_lb
  }
}
output "lb_nat_rule" {
  value = module.lb_nat_rule
}

module "lb_outbound_rule" {
  source   = "./modules/networking/lb_outbound_rule"
  for_each = local.networking.lb_outbound_rule

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  # if resource_group.name is defined and not null, use that.  if resource_group_name is defined and not null, use that.  otherwise calculate name using combined_objects_resource_groups
  resource_group_name = try(each.value.resource_group.name, null) != null ? each.value.resource_group.name : try(each.value.resource_group_name, null) != null ? each.value.resource_group_name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    resource_group          = local.combined_objects_resource_groups
    lb                      = local.combined_objects_lb
    lb_backend_address_pool = local.combined_objects_lb_backend_address_pool
  }
}
output "lb_outbound_rule" {
  value = module.lb_outbound_rule
}

module "lb_probe" {
  source   = "./modules/networking/lb_probe"
  for_each = local.networking.lb_probe

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    resource_group = local.combined_objects_resource_groups
    lb             = local.combined_objects_lb
  }
}
output "lb_probe" {
  value = module.lb_probe
}
module "lb_rule" {
  source   = "./modules/networking/lb_rule"
  for_each = local.networking.lb_rule

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  # if resource_group.name is defined and not null, use that.  if resource_group_name is defined and not null, use that.  otherwise calculate name using combined_objects_resource_groups
  resource_group_name = try(each.value.resource_group.name, null) != null ? each.value.resource_group.name : try(each.value.resource_group_name, null) != null ? each.value.resource_group_name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  # if backend_address_pool_ids is defined and not null, use that.  if backend_address_pool is defined and not null, calculate ids using combined_objects_lb_backend_address_pool
  backend_address_pool_ids = try(each.value.backend_address_pool_ids, null) != null ? each.value.backend_address_pool_ids : try(each.value.backend_address_pool, null) != null ? [
    for k, v in each.value.backend_address_pool : local.combined_objects_lb_backend_address_pool[try(v.lz_key, local.client_config.landingzone_key)][v.key].id
  ] : null
  # if probe_id is defined and non null, use that.  if probe.key is defined and not null, calculate id using combined_objects_lb_probe
  probe_id = try(each.value.probe_id, null) != null ? each.value.probe_id : try(each.value.probe.key, null) != null ? local.combined_objects_lb_probe[try(each.value.probe.lz_key, local.client_config.landingzone_key)][each.value.probe.key].id : null

  remote_objects = {
    resource_group          = local.combined_objects_resource_groups
    lb                      = local.combined_objects_lb
    lb_backend_address_pool = local.combined_objects_lb_backend_address_pool
    lb_probe                = local.combined_objects_lb_probe
  }
}
output "lb_rule" {
  value = module.lb_rule
}
