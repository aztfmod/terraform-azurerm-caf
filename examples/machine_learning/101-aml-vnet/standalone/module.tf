module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  storage_accounts   = var.storage_accounts
  keyvaults          = var.keyvaults

  webapp = {
   azurerm_application_insights      = var.azurerm_application_insights
  }

  database = {
    machine_learning_workspaces = var.machine_learning_workspaces 
  }

  networking = {
    vnets  = var.vnets
    network_security_group_definition = var.network_security_group_definition
  }
}
  
