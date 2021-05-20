landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "wvd_post"
  tfstates = {
    examples = {
      tfstate = "wvd-pre.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}