module "certificate" {
  source   = "./certificate"
  for_each = var.settings

  name        = each.value.secret_name
  password    = try(each.value.password, null)
  contents    = can(each.value.output_key) && (can(each.value.resource_key) || can(each.value.attribute_key)) ? lookup(lookup(var.objects[each.value.output_key], try(each.value.resource_key, ""), var.objects[each.value.output_key]), each.value.attribute_key, null) : each.value.contents
  keyvault_id = var.keyvault.id
}