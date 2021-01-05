module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  storage_accounts = var.storage_accounts 
  keyvaults = var.keyvaults
  role_mapping  = var.role_mapping 

  database = {
    synapse_workspaces = var.synapse_workspaces
  }


}
  
