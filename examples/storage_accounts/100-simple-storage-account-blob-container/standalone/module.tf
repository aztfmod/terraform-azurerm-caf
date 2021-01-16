module "caf" {
  source          = "../../../../"
  global_settings = var.global_settings
  tags            = var.tags
  resource_groups = var.resource_groups
  storage_accounts= var.storage_accounts

}

