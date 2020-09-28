locals {
  backend_pools = {
    for key, value in var.application_gateway_applications : key => value.backend_pool
  }

  backend_http_settings = {
    for key, value in var.application_gateway_applications : key => value.backend_http_settings
  }
}