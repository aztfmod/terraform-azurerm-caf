resource "gitlab_project" "project" {
  name               = lookup(var.project, "name", "")
  description        = lookup(var.project, "description", "")
  visibility_level   = lookup(var.project, "visibility", "private")
}

resource "gitlab_project_variable" "variable" {
  for_each    = lookup(var.project, "variables", {})

  project   = gitlab_project.project.id
  key       = each.key
  value     = lookup(each.value, "value", "")
  protected = lookup(each.value, "protected", false)
  masked    = lookup(each.value, "masked", false)
}
