resource "azuredevops_project" "project" {
  name               = var.project.name
  description        = lookup(var.project, "description", "")
  visibility         = lookup(var.project, "visibility", "private")
  version_control    = lookup(var.project, "version_control", "Git")
  work_item_template = lookup(var.project, "work_item_template", "Agile")
}