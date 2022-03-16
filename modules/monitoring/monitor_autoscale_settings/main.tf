terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

locals {
  target_resource_id = coalesce(
    try(var.remote_objects.virtual_machine_scale_sets[var.client_config.landingzone_key][var.settings.vmss_key].id,null), # for backward compatibility

    try(var.remote_objects.virtual_machine_scale_sets[var.settings.target_resource.lz_key][var.settings.target_resource.vmss_key].id,null),
    try(var.remote_objects.virtual_machine_scale_sets[var.client_config.landingzone_key][var.settings.target_resource.vmss_key].id,null),
    
    try(var.remote_objects.app_service_plans[var.settings.target_resource.lz_key][var.settings.target_resource.app_service_plan_key].id,null),
    try(var.remote_objects.app_service_plans[var.client_config.landingzone_key][var.settings.target_resource.app_service_plan_key].id,null),
  )
}
