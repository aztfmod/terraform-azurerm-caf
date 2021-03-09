resource "gitlab_project" "project" {
  name               = var.project.name
  description        = lookup(var.project, "description", "")
  visibility         = lookup(var.project, "visibility", "private")
}
