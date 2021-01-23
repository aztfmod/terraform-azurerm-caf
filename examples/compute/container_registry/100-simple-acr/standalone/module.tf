module "caf" {
  source          = "../../../../../"
  global_settings = var.global_settings
  tags            = var.tags
  resource_groups = var.resource_groups

  compute = {
    azure_container_registries = var.azure_container_registries
  }

}