module "caf" {
  source = "../../../../../caf"

  global_settings             = var.global_settings
  resource_groups             = var.resource_groups
  database = {
    cosmos_db = var.cosmos_dbs
  }
}
