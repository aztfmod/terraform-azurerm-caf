locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}
