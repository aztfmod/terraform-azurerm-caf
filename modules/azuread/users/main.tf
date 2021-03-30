terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

data "azuread_domains" "aad_domains" {
  only_initial = true
}