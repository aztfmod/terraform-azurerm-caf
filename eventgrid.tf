module "eventgrid_domain" {
  source   = "./modules/messaging/eventgrid/eventgrid_domain"
  for_each = local.messaging.eventgrid_domain

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
      try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
      try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
      try(each.value.resource_group.name, null)
  )

  location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]

  remote_objects = {
        resource_group = local.combined_objects_resource_groups
        vnets = local.combined_objects_networking
        private_dns = local.combined_objects_private_dns
  }
}
output "eventgrid_domain" {
  value = module.eventgrid_domain
}

module "eventgrid_topic" {
  source   = "./modules/messaging/eventgrid/eventgrid_topic"
  for_each = local.messaging.eventgrid_topic

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
      try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
      try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
      try(each.value.resource_group.name, null)
  )

  location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]

  remote_objects = {
        resource_group = local.combined_objects_resource_groups
  }
}
output "eventgrid_topic" {
  value = module.eventgrid_topic
} 

module "eventgrid_event_subscription" {
  source   = "./modules/messaging/eventgrid/eventgrid_event_subscription"
  for_each = local.messaging.eventgrid_event_subscription

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value


  remote_objects = {
  }
}
output "eventgrid_event_subscription" {
  value = module.eventgrid_event_subscription
} 

module "eventgrid_domain_topic" {
  source   = "./modules/messaging/eventgrid/eventgrid_domain_topic"
  for_each = local.messaging.eventgrid_domain_topic

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
      try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
      try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
      try(each.value.resource_group.name, null)
  )


  remote_objects = {
        resource_group = local.combined_objects_resource_groups
        eventgrid_domain = local.combined_objects_eventgrid_domains
  }
}
output "eventgrid_domain_topic" {
  value = module.eventgrid_domain_topic
} 