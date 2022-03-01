module "api_management" {
  source   = "./modules/apim/api_management"
  for_each = local.apim.api_management

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    resource_group     = local.combined_objects_resource_groups
    managed_identities = local.combined_objects_managed_identities
  }
}
output "api_management" {
  value = module.api_management
}

module "api_management_api" {
  source   = "./modules/apim/api_management_api"
  for_each = local.apim.api_management_api

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_api" {
  value = module.api_management_api
}

module "api_management_logger" {
  source   = "./modules/apim/api_management_logger"
  for_each = local.apim.api_management_logger

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )


  remote_objects = {
    resource_group       = local.combined_objects_resource_groups
    api_management       = local.combined_objects_api_management
    application_insights = local.combined_objects_application_insights
  }
}
output "api_management_logger" {
  value = module.api_management_logger
}
module "api_management_api_diagnostic" {
  source   = "./modules/apim/api_management_api_diagnostic"
  for_each = local.apim.api_management_api_diagnostic

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_logger_id = coalesce(
    try(local.combined_objects_api_management_logger[each.value.api_management_logger.lz_key][each.value.api_management_logger.key].id, null),
    try(local.combined_objects_api_management_logger[local.client_config.landingzone_key][each.value.api_management_logger.key].id, null),
    try(each.value.api_management_logger.id, null)
  )

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )
  api_name = coalesce(
    try(local.combined_objects_api_management_api[each.value.api.lz_key][each.value.api.key].name, null),
    try(local.combined_objects_api_management_api[local.client_config.landingzone_key][each.value.api.key].name, null),
    try(each.value.api.name, null)
  )
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    #api_management_logger = local.combined_objects_api_management_logger
    #api_management        = local.combined_objects_api_management
    #resource_group        = local.combined_objects_resource_groups
  }
}
output "api_management_api_diagnostic" {
  value = module.api_management_api_diagnostic
}
module "api_management_api_operation" {
  source   = "./modules/apim/api_management_api_operation"
  for_each = local.apim.api_management_api_operation

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_name = coalesce(
    try(local.combined_objects_api_management_api[each.value.api.lz_key][each.value.apit.key].name, null),
    try(local.combined_objects_api_management_api[local.client_config.landingzone_key][each.value.api.key].name, null),
    try(each.value.api.name, null)
  )

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_api_operation" {
  value = module.api_management_api_operation
}

module "api_management_backend" {
  source   = "./modules/apim/api_management_backend"
  for_each = local.apim.api_management_backend

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_backend" {
  value = module.api_management_backend
}

module "api_management_api_policy" {
  source   = "./modules/apim/api_management_api_policy"
  for_each = local.apim.api_management_api_policy

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_name = coalesce(
    try(local.combined_objects_api_management_api[each.value.api.lz_key][each.value.apit.key].name, null),
    try(local.combined_objects_api_management_api[local.client_config.landingzone_key][each.value.api.key].name, null),
    try(each.value.api.name, null)
  )
  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_api_policy" {
  value = module.api_management_api_policy
}

module "api_management_api_operation_tag" {
  source   = "./modules/apim/api_management_api_operation_tag"
  for_each = local.apim.api_management_api_operation_tag

  api_operation_id = coalesce(
    try(local.combined_objects_api_management_api_operation[each.value.api_operation.lz_key][each.value.api_operation.key].id, null),
    try(local.combined_objects_api_management_api_operation[local.client_config.landingzone_key][each.value.api_operation.key].id, null),
    try(each.value.api_operation.id, null)
  )


  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value


  remote_objects = {
  }
}
output "api_management_api_operation_tag" {
  value = module.api_management_api_operation_tag
}
module "api_management_api_operation_policy" {
  source   = "./modules/apim/api_management_api_operation_policy"
  for_each = local.apim.api_management_api_operation_policy

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_name = coalesce(
    try(local.combined_objects_api_management_api[each.value.api.lz_key][each.value.api.key].name, null),
    try(local.combined_objects_api_management_api[local.client_config.landingzone_key][each.value.api.key].name, null),
    try(each.value.api.name, null)
  )

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )

  remote_objects = {
    api_management               = local.combined_objects_api_management
    resource_group               = local.combined_objects_resource_groups
    api_management_api_operation = local.combined_objects_api_management_api_operation
  }
}
output "api_management_api_operation_policy" {
  value = module.api_management_api_operation_policy
}

module "api_management_certificate" {
  source   = "./modules/apim/api_management_certificate"
  for_each = local.apim.api_management_certificate

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    api_management                = local.combined_objects_api_management
    resource_group                = local.combined_objects_resource_groups
    keyvault_certificates         = local.combined_objects_keyvault_certificates
    keyvault_certificate_requests = local.combined_objects_keyvault_certificate_requests
    managed_identities            = local.combined_objects_managed_identities
  }
}
output "api_management_certificate" {
  value = module.api_management_certificate
}

module "api_management_custom_domain" {
  source   = "./modules/apim/api_management_custom_domain"
  for_each = local.apim.api_management_custom_domain

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_id = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].id, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].id, null),
    try(each.value.api_management.id, null)
  )


  remote_objects = {
    api_management                = local.combined_objects_api_management
    keyvault_certificates         = local.combined_objects_keyvault_certificates
    keyvault_certificate_requests = local.combined_objects_keyvault_certificate_requests
  }
}
output "api_management_custom_domain" {
  value = module.api_management_custom_domain
}

module "api_management_diagnostic" {
  source   = "./modules/apim/api_management_diagnostic"
  for_each = local.apim.api_management_diagnostic

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )

  api_management_logger_id = coalesce(
    try(local.combined_objects_api_management_logger[each.value.api_management_logger.lz_key][each.value.api_management_logger.key].id, null),
    try(local.combined_objects_api_management_logger[local.client_config.landingzone_key][each.value.api_management_logger.key].id, null),
    try(each.value.api_management_logger.id, null)
  )

  remote_objects = {
    api_management        = local.combined_objects_api_management
    resource_group        = local.combined_objects_resource_groups
    api_management_logger = local.combined_objects_api_management_logger
  }
}
output "api_management_diagnostic" {
  value = module.api_management_diagnostic
}

module "api_management_user" {
  source   = "./modules/apim/api_management_user"
  for_each = local.apim.api_management_user

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_user" {
  value = module.api_management_user
}

module "api_management_gateway" {
  source   = "./modules/apim/api_management_gateway"
  for_each = local.apim.api_management_gateway

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_gateway" {
  value = module.api_management_gateway
}

module "api_management_gateway_api" {
  source   = "./modules/apim/api_management_gateway_api"
  for_each = local.apim.api_management_gateway_api

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    api_management_api     = local.combined_objects_api_management_api
    api_management         = local.combined_objects_api_management
    resource_group         = local.combined_objects_resource_groups
    api_management_gateway = local.combined_objects_api_management_gateway
  }
}
output "api_management_gateway_api" {
  value = module.api_management_gateway_api
}

module "api_management_group" {
  source   = "./modules/apim/api_management_group"
  for_each = local.apim.api_management_group

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_group" {
  value = module.api_management_group
}