resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  name                     = var.settings.name
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
  dns_zone_id              = try(var.settings.dns_zone_id, null)
  host_name                = var.settings.host_name

  tls {
    certificate_type        = try(var.settings.tls.certificate_type, null)
    minimum_tls_version     = try(var.settings.tls.min_tls_version, null)
    cdn_frontdoor_secret_id = try(var.settings.tls.cdn_frontdoor_secret_id, null)
  }
}