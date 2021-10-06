module "eventgrid_topics" {
  source      = "./modules/messaging/eventgrid_topics"
  for_each = try(local.messaging.eventgrid_topics, {})

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "eventgrid_topics" {
  value = module.eventgrid_topics
}

// module "eventgrid_topics_diagnostics" {
//   source   = "./modules/diagnostics"
//   // for_each = var.eventgrid_topics
//   for_each = local.messaging.eventgrid_topics

//   resource_id       = module.eventgrid_topics[each.key].id
//   // resource_location = module.eventgrid_topics[each.key].location
//   resource_location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
//   diagnostics       = local.combined_diagnostics
//   profiles          = try(each.value.diagnostic_profiles, {})
// }