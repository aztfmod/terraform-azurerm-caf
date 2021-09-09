
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
    region2 = "centralus"
  }
}

// landingzone = {
//   backend_type        = "azurerm"
//   global_settings_key = "caf_foundations_sharedservices"
//   level               = "level2"
//   key                 = "caf_level2_acs_vx1.tfstate"
//   tfstates = {
//     caf_foundations_sharedservices = {
//       level   = "lower"
//       tfstate = "caf_foundations_sharedservices.tfstate"
//     }    
//   }
// }


resource_groups = {
  rg_region1 = {
    name = "example-communication-services-re1"
  }
}




