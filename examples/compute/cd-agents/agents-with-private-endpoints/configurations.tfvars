landingzone = {
  backend_type = "azurerm"
  level        = "level0"
  key          = "bootstrap"
}

global_settings = {
  default_region = "region1"
  inherit_tags   = true
  passthrough    = false
  prefix         = ""
  random_length  = 3
  regions = {
    region1 = "southeastasia"
  }
  use_slug = true

}

resource_groups = {
  bootstrap = {
    name   = "bootstrap"
    region = "region1"
  }
  agents = {
    name   = "bootstrap-agents"
    region = "region1"
  }
}

