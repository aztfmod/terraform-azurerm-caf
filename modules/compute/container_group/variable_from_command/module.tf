data "external" "get_variable_for" {
  for_each = try(var.variables, {})

  program = [
    "bash", "-c", each.value
  ]

  query = {
    trigger = var.trigger
  }
}

output "variables" {
  value = local.variables_from_command
}

locals {
  variables_from_command = {
    for key, value in try(var.variables, {}) : key => data.external.get_variable_for[key].result.value
  }
}