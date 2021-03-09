module "gitlab_projects" {
  source          = "./modules/devops/providers/gitlab"
  for_each        = var.gitlab_projects
  project         = each.value
  global_settings = local.global_settings
  client_config   = local.client_config
}

output gitlab_projects {
  value = module.gitlab_projects
}
