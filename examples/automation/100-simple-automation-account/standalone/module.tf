module "caf" {
  source = "../../../../"

  global_settings = var.global_settings
  tags            = var.tags
  resource_groups = var.resource_groups
  shared_services = { automations = var.automations }
}

