global_settings = {
  default_region = "region1"
  inherit_tags   = true
  regions = {
    region1 = "westeurope"
    region2 = "northeurope"
  }
  tags          = {}
  use_slug      = true
  passthrough   = false
  suffixes      = ["westeurope"]
  random_length = 0
  prefixes      = ["fl"]
}
