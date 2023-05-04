
module "random_strings" {
  source   = "./modules/random_string"
  for_each = try(var.random_strings, {})

  random_string_length                   = each.value.length
  random_string_allow_special_characters = try(each.value.special, false)
  random_string_allow_upper_case         = try(each.value.upper, false)
  random_string_allow_numbers            = try(each.value.number, each.value.numeric, false)
}

output "random_strings" {
  value = module.random_strings

}
