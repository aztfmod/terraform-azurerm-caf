
resource "azurecaf_name" "frontdoor" {
  name          = var.settings.name
  resource_type = "azurerm_frontdoor"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_frontdoor" "frontdoor" {
  name                = azurecaf_name.frontdoor.result
  location            = var.location
  resource_group_name = var.resource_group_name
  enforce_backend_pools_certificate_name_check = try(var.settings.certificate_name_check, false)
  tags                = local.tags


  routing_rule {
    name                  =   var.settings.routing_rule.name
    frontend_endpoints    =   var.settings.routing_rule.frontend_endpoints
    accepted_protocols    =   try(var.settings.routing_rule.accepted_protocols, null)
    patterns_to_match     =   try(var.settings.routing_rule.patterns_to_match, ["/*"])
    forwarding_configuration {
      backend_pool_name  =    try(var.settings.backend_pool.name, null)
    }
  }

  backend_pools_send_receive_timeout_seconds = try(var.settings.backend_pools_send_receive_timeout_seconds, 60)
  load_balancer_enabled  =  try(var.settings.load_balancer_enabled, true)
  friendly_name          =  try(var.settings.backend_pool.name, null)
  
  backend_pool_load_balancing {
    name = var.settings.backend_pool_load_balancing.name
  }

  backend_pool_health_probe {
    name = var.settings.backend_pool_health_probe.name
  } 
    
  backend_pool {
    name = var.settings.backend_pool.name
    backend {
      host_header = var.settings.backend_pool.host_header
      address     = var.settings.backend_pool.address
      http_port   = var.settings.backend_pool.http_port
      https_port  = var.settings.backend_pool.https_port
    }

    load_balancing_name = var.settings.backend_pool.load_balancing_name
    health_probe_name   = var.settings.backend_pool.health_probe_name
  }

  frontend_endpoint {
    name                              = var.settings.frontend_endpoint.name
    host_name                         = format("%s.azurefd.net", azurecaf_name.frontdoor.result)
    custom_https_provisioning_enabled = var.settings.frontend_endpoint.custom_https_provisioning_enabled
  }
}
  