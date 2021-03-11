module "gitlab_projects" {
  source          = "./modules/devops/providers/gitlab"
  project         = local.shared_services.gitlab_projects.project
  token           = local.shared_services.gitlab_projects.token
}

output gitlab_projects {
  value = module.gitlab_projects
}
