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
  tags = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))

  # skus = {
  #   "F1" = "Free"
  #   "D1" = "Shared"
  #   "B1" = "Basic"
  #   "B2" = "Basic"
  #   "B3" = "Basic"
  #   "S1" = "Standard"
  #   "S2" = "Standard"
  #   "S3" = "Standard"
  #   "S4" = "Standard"
  #   "P1" = "Premium"
  #   "P2" = "Premium"
  #   "P3" = "Premium"
  #   "I1" = "Isolated"
  #   "I2" = "Isolated"
  #   "I3" = "Isolated"
  #   "PC2" = "PremiumContainer"
  #   "PC3" = "PremiumContainer"
  #   "PC4" = "PremiumContainer"
  #   "EI1" = "ElasticIsolated"
  #   "EI2" = "ElasticIsolated"
  #   "EI3" = "ElasticISolated"
  #   "U1_HyperV_S1" = {
  #     name = "U1"
  #     tier = "HyperV_S1"
  #   }
  #   "U1_HyperV_P2v2" = {
  #     name = "U1"
  #     tier = "HyperV_P2v2"
  #   }
  #   "U1_HyperV_P3v2" = {
  #     name = "U1"
  #     tier = "HyperV_P3v2"
  #   }
  #   "U1_LinuxFree" = {
  #     name = "U1"
  #     tier = "LinuxFree"
  #   }
  #   "U2_LinuxFree" = {
  #     name = "U2"
  #     tier = "LinuxFree"
  #   }
  #   "U3_LinuxFree" = {
  #     name = "U3"
  #     tier = "LinuxFree"
  #   }
  # }
}

