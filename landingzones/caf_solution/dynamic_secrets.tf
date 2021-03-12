module dynamic_keyvault_secrets {
  source = "../../modules/security/dynamic_keyvault_secrets/"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.solution.keyvaults[each.key]
  objects  = module.solution
}