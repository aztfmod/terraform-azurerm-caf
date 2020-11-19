locals {

  shared_services = {
    recovery_vaults      = try(var.shared_services.recovery_vaults, {})
    automations          = try(var.shared_services.automations, {})
    monitoring           = try(var.shared_services.monitoring, {})
    shared_image_gallery = try(var.shared_services.shared_image_gallery, {})
    packer               = try(var.shared_services.packer, {})
  }


}