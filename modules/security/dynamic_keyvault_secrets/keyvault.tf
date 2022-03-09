module "secret" {
  source = "./secret"
  for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) == null
  }

  name        = each.value.secret_name
  value       = can(each.value.value) ? each.value.value : var.objects[each.value.output_key][try(each.value.resource_key, each.value.attribute_key)][try(each.value.attribute_key, "")]
  keyvault_id = var.keyvault.id
}

module "secret_value" {
  source = "./secret"
  for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) != null && try(value.value, null) != ""
  }

  name        = each.value.secret_name
  value       = each.value.value
  keyvault_id = var.keyvault.id
}

module "secret_immutable" {
  source = "./secret_immutable"
  for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) == ""
  }

  name        = each.value.secret_name
  value       = can(each.value.value) ? each.value.value : var.objects[each.value.output_key][try(each.value.resource_key, each.value.attribute_key)][try(each.value.attribute_key, "")]
  keyvault_id = var.keyvault.id
}
