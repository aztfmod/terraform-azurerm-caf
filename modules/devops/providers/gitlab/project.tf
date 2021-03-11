resource "gitlab_project" "project" {
  name               = lookup(var.project, "name", "")
  description        = lookup(var.project, "description", "")
  visibility_level   = lookup(var.project, "visibility", "private")
}
