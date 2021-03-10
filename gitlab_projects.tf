module "gitlab_projects" {
  source          = "./modules/devops/providers/gitlab"
  for_each        = var.gitlab_projects
  project         = each.value
  gitlab_token    = local.gitlab_token
}

output gitlab_projects {
  value = module.gitlab_projects
}
