landingzone = {
  backend_type        = "azurerm"
  level               = "level2"
  key                 = "examples_vnet_spoke"
  global_settings_key = "examples_vnet_hub"
  tfstates = {
    examples_vnet_hub = {
      tfstate   = "examples_vnet_hub.tfstate"
      workspace = "tfstate"
      level     = "current"
    }
  }
}
