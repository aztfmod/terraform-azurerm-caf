module "api_management" {
  source   = "./modules/apim/api_management"
  for_each = local.apim.api_management

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  vnets               = local.combined_objects_networking
  public_ip_addresses = local.combined_objects_public_ip_addresses
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)

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

  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

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

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name

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

  api_management_logger_id = can(each.value.api_management_logger.id) ? each.value.api_management_logger.id : local.combined_objects_api_management_logger[try(each.value.api_management_logger.lz_key, local.client_config.landingzone_key)][each.value.api_management_logger.key].id
  api_management_name      = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name      = can(each.value.resource_group.name) ? each.value.resource_group.name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  api_name                 = can(each.value.api.name) ? each.value.api.name : local.combined_objects_api_management_api[try(each.value.api.lz_key, local.client_config.landingzone_key)][each.value.api.key].name

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

  api_name            = can(each.value.api.name) ? each.value.api.name : local.combined_objects_api_management_api[try(each.value.api.lz_key, local.client_config.landingzone_key)][each.value.api.key].name
  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

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

  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

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

  api_name            = can(each.value.api.name) ? each.value.api.name : local.combined_objects_api_management_api[try(each.value.api.lz_key, local.client_config.landingzone_key)][each.value.api.key].name
  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

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

  api_operation_id = can(each.value.api_operation.id) ? each.value.api_operation.id : local.combined_objects_api_management_api_operation[try(each.value.api_operation.lz_key, local.client_config.landingzone_key)][each.value.api_operation.key].id

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

  api_name            = can(each.value.api.name) ? each.value.api.name : local.combined_objects_api_management_api[try(each.value.api.lz_key, local.client_config.landingzone_key)][each.value.api.key].name
  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

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

  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

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

  api_management_id = can(each.value.api_management.id) ? each.value.api_management.id : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].id

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

  api_management_name      = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name      = can(each.value.resource_group.name) ? each.value.resource_group.name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  api_management_logger_id = can(each.value.api_management_logger.id) ? each.value.api_management_logger.id : local.combined_objects_api_management_logger[try(each.value.api_management_logger.lz_key, local.client_config.landingzone_key)][each.value.api_management_logger.key].id

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

  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

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

module "api_management_subscription" {
  source   = "./modules/apim/api_management_subscription"
  for_each = local.apim.api_management_subscription

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  product_id          = can(each.value.product.product_id) || can(each.value.product.key) == false ? try(each.value.product.product_id, null) : local.combined_objects_api_management_product[try(each.value.product.lz_key, local.client_config.landingzone_key)][each.value.product.key].id

  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_subscription" {
  value = module.api_management_subscription
}

module "api_management_product" {
  source   = "./modules/apim/api_management_product"
  for_each = local.apim.api_management_product

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_name = can(each.value.api_management.name) ? each.value.api_management.name : local.combined_objects_api_management[try(each.value.api_management.lz_key, local.client_config.landingzone_key)][each.value.api_management.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_product" {
  value = module.api_management_product
}
