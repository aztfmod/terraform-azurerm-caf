
resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_api_management_backend"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_api_management_backend" "apim" {
  name                = azurecaf_name.apim.result
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  protocol            = var.settings.protocol
  url                 = var.settings.url
  dynamic "credentials" {
    for_each = try(var.settings.credentials, null) != null ? [var.settings.credentials] : []
    content {
      dynamic "authorization" {
        for_each = try(var.settings.authorization, null) != null ? [var.settings.authorization] : []
        content {
          parameter = try(authorization.value.parameter, null)
          scheme    = try(authorization.value.scheme, null)
        }
      }
      certificate = try(credentials.value.certificate, null)
      header      = try(credentials.value.header, null)
      query       = try(credentials.value.query, null)
    }
  }
  description = try(var.settings.description, null)
  dynamic "proxy" {
    for_each = try(var.settings.proxy, null) != null ? [var.settings.proxy] : []
    content {
      password = try(proxy.value.password, null)
      url      = try(proxy.value.url, null)
      username = try(proxy.value.username, null)
    }
  }
  resource_id = try(var.settings.resource_id, null)
  dynamic "service_fabric_cluster" {
    for_each = try(var.settings.service_fabric_cluster, null) != null ? [var.settings.service_fabric_cluster] : []
    content {
      client_certificate_thumbprint    = try(service_fabric_cluster.value.client_certificate_thumbprint, null)
      client_certificate_id            = try(service_fabric_cluster.value.client_certificate_id, null)
      management_endpoints             = try(service_fabric_cluster.value.management_endpoints, null)
      max_partition_resolution_retries = try(service_fabric_cluster.value.max_partition_resolution_retries, null)
      server_certificate_thumbprints   = try(service_fabric_cluster.value.server_certificate_thumbprints, null)
      dynamic "server_x509_name" {
        for_each = try(var.settings.server_x509_name, null) != null ? [var.settings.server_x509_name] : []
        content {
          issuer_certificate_thumbprint = try(server_x509_name.value.issuer_certificate_thumbprint, null)
          name                          = try(server_x509_name.value.name, null)
        }
      }
    }
  }
  title = try(var.settings.title, null)
  dynamic "tls" {
    for_each = try(var.settings.tls, null) != null ? [var.settings.tls] : []
    content {
      validate_certificate_chain = try(tls.value.validate_certificate_chain, null)
      validate_certificate_name  = try(tls.value.validate_certificate_name, null)
    }
  }
}