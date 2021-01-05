module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  storage_accounts  = var.storage_accounts
  keyvaults  = var.keyvaults

  database = {
    postgresql_servers  = var.postgresql_servers
  }

  networking = {
    vnets  = var.vnets
  }
}
  
