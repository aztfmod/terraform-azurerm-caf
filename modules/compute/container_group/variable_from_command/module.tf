data "azurecaf_environment_variable" "get_variable_for" {
  for_each = try(var.variables, {})

  name           = each.value
  fails_if_empty = true
}

output "variables" {
  value = local.variables_from_command
}

locals {
  variables_from_command = {
    for key, value in try(var.variables, {}) : key => data.azurecaf_environment_variable.get_variable_for[key].value
  }
}