module "azure_devops_projects" {
  source          = "./modules/devops/providers/azure-devops"
  for_each        = var.azure_devops_projects
  project         = each.value
  global_settings = local.global_settings
  client_config   = local.client_config
}

output azure_devops_projects {
  value = module.azure_devops_projects
}
