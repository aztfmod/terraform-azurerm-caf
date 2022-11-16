resource "random_string" "rs" {
  length  = var.random_string_length
  special = var.random_string_allow_special_characters
  upper   = var.random_string_allow_upper_case
  numeric = var.random_string_allow_numbers
}
