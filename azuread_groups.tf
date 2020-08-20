module azuread_groups {
  source = "./modules/azuread/groups"

  for_each = var.azuread_groups

  global_settings = local.global_settings
  azuread_groups  = each.value
}

output azuread_groups {
  value     = module.azuread_groups
  sensitive = true
}