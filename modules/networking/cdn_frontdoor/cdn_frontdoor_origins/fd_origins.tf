resource "azurerm_cdn_frontdoor_origin" "this" {
  name                           = var.settings.name
  cdn_frontdoor_origin_group_id  = var.cdn_frontdoor_origin_group_id
  certificate_name_check_enabled = try(var.settings.certificate_name_check_enabled, null)
  host_name                      = var.settings.host_name
  http_port                      = try(var.settings.http_port, null)
  https_port                     = try(var.settings.https_port, null)
  origin_host_header             = try(var.settings.origin_host_header, null)
  priority                       = try(var.settings.priority, null)
  weight                         = try(var.settings.weight, null)

  dynamic "private_link" {
    for_each = try(var.settings.private_link, null) == null ? [] : [var.settings.private_link]

    content {
      request_message        = try(private_link.request_message, null)
      target_type            = try(private_link.target_type, null)
      location               = var.location
      private_link_target_id = private_link.private_link_target_id
    }
  }
}