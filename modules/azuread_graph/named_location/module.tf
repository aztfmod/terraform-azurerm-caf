 
resource "azuread_named_location" "naml" {
  display_name = var.settings.display_name
  dynamic "ip" {
    for_each = try(var.settings.ip, null) != null ? [var.settings.ip] : []
    content { 
      ip_ranges = ip.value.ip_ranges
      trusted = try(ip.value.trusted, null)
    }
  }
  dynamic "country" {
    for_each = try(var.settings.country, null) != null ? [var.settings.country] : []
    content { 
      countries_and_regions = country.value.countries_and_regions
      include_unknown_countries_and_regions = try(country.value.include_unknown_countries_and_regions, null)
    }
  }
}
