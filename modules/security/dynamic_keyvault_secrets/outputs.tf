locals {
  secret_output = {for key, value in var.settings : 
    key => merge(
      try(module.secret[key].secret, {}),
      try(module.secret_value[key].secret, {}),
      try(module.secret_immutable[key].secret, {}),
      try(module.secret_dynamic[key].secret, {}),
    )
  }

}
output "secrets" {
  value = local.secret_output
}