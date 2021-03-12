locals {
  # combined = {
  #   app_service_environments         = merge(local.remote.app_service_environments, tomap({ (var.landingzone.key) = module.caf.app_service_environments }))
  #   app_service_plans                = merge(local.remote.app_service_plans, tomap({ (var.landingzone.key) = module.caf.app_service_plans }))
  #   app_services                     = merge(local.remote.app_services, tomap({ (var.landingzone.key) = module.caf.app_services }))
  #   application_gateway_applications = merge(local.remote.application_gateway_applications, tomap({ (var.landingzone.key) = module.caf.application_gateway_applications }))
  #   application_gateways             = merge(local.remote.application_gateways, tomap({ (var.landingzone.key) = module.caf.application_gateways }))
  #   managed_identities               = merge(local.remote.managed_identities, tomap({ (var.landingzone.key) = module.caf.managed_identities }))
  #   mssql_elastic_pools              = merge(local.remote.mssql_elastic_pools, tomap({ (var.landingzone.key) = module.caf.mssql_elastic_pools }))
  #   mssql_servers                    = merge(local.remote.mssql_servers, tomap({ (var.landingzone.key) = module.caf.mssql_servers }))
  #   private_dns                      = merge(local.remote.private_dns, tomap({ (var.landingzone.key) = module.caf.private_dns }))
  #   public_ip_addresses              = merge(local.remote.public_ip_addresses, tomap({ (var.landingzone.key) = module.caf.public_ip_addresses }))
  #   vnets                            = merge(local.remote.vnets, tomap({ (var.landingzone.key) = module.caf.vnets }))
  # }

}