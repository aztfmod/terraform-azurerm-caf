variable "random_string_length" {
  description = "(Required) The length of the random string to be created"
}
variable "random_string_allow_special_characters" {
  description = "Allows special characters in the random string to be created"
  default     = false
}
variable "random_string_allow_upper_case" {
  description = "Allows upper case letters in the random string to be created"
  default     = false
}
variable "random_string_allow_numbers" {
  description = "Allows numbers in the random string to be created"
  default     = false
}
