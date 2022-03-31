azuread_named_locations = {
  anl1 = {
    display_name = "IP Named Location"
    ip = {
      ip_ranges = [
        "1.1.1.1/32",
        "2.2.2.2/32",
      ]
      trusted = true
    }
  }
  anl2 = {
    display_name = "Country Named Location"
    country = {
      countries_and_regions = [
        "GB",
        "US",
      ]
      include_unknown_countries_and_regions = false
    }
  }
}