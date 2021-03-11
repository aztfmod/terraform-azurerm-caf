module "gitlab_projects" {
  source          = "./modules/devops/providers/gitlab"
  project         = var.gitlab_projects.project
  token           = var.gitlab_projects.token
}

output gitlab_projects {
  value = module.gitlab_projects
}
