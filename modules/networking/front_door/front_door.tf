
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
  enforce_backend_pools_certificate_name_check = false
  tags                = local.tags


  routing_rule {
    name                  =   var.settings.routing_rule.name
    frontend_endpoints    =   var.settings.routing_rule.frontend_endpoints
    accepted_protocols    =   try(var.settings.routing_rule.accepted_protocols, null)
    patterns_to_match     =   try(var.settings.routing_rule.patterns_to_match, null)
    forwarding_configuration {
      backend_pool_name  =    try(var.settings.routing_rule.backend_pool_name, null)
    }
  }
      # dynamic "forwarding_configuration" {
      #   for_each = lookup(var.settings.routing_rule, "forwarding_configuration", false) == false ? [] : [1]

      #   content {
      #     forwarding_protocol = try(var.settings.routing_rule.forwarding_configuration.forwarding_protocol, null)
      #     backend_pool_name   = var.settings.routing_rule.forwarding_configuration.backend_pool_name
      #     cache_enabled       = try(var.settings.routing_rule.forwarding_configuration.cache_enabled, false)
      #     cache_use_dynamic_compression =  try(var.settings.routing_rule.forwarding_configuration.cache_use_dynamic_compression, false)
      #     cache_query_parameter_strip_directive = try(var.settings.routing_rule.forwarding_configuration.cache_query_parameter_strip_directive, "StripAll")
      #   }
      # }
    # }
  backend_pool_load_balancing {
    name = var.settings.backend_pool_load_balancing.name
  }

  backend_pool_health_probe {
    name = var.settings.backend_pool_health_probe.name
  }
  
  backend_pool {
    name = "exampleBackendBing"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "exampleLoadBalancingSettings1"
    health_probe_name   = "exampleHealthProbeSetting1"
  }

  frontend_endpoint {
    name                              = "exampleFrontendEndpoint1"
    host_name                         = "example-FrontDoor.azurefd.net"
    custom_https_provisioning_enabled = false
  }
}
