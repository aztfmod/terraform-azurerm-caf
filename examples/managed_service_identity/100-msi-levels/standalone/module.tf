module "caf" {
  source = "../../../../"

  global_settings    = var.global_settings
  resource_groups    = var.resource_groups
  managed_identities = var.managed_identities
}
