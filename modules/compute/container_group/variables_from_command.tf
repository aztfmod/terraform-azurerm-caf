module "variables_from_command" {
  source = "./variable_from_command"

  for_each = {
    for key, value in local.combined_containers : key => value
    if try(value.variables_from_command, null) != null
  }

  variables = each.value.variables_from_command
  trigger   = sha512(jsonencode(var.settings))
}

module "secure_variables_from_command" {
  source = "./variable_from_command"

  for_each = {
    for key, value in local.combined_containers : key => value
    if try(value.secure_variables_from_command, null) != null
  }

  variables = each.value.secure_variables_from_command
  trigger   = sha512(jsonencode(var.settings))
}
