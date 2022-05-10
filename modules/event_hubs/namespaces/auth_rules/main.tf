terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}


locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
}
