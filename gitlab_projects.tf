module "gitlab_projects" {
  source          = "./modules/devops/providers/gitlab"
  project         = var.gitlab_projects.project
}

output gitlab_projects {
  value = module.gitlab_projects
}
