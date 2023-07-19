variable "random_string_length" {
  type        = any
  description = "(Required) The length of the random string to be created"
}
variable "random_string_allow_special_characters" {
  type        = bool
  description = "Allows special characters in the random string to be created"
  default     = false
}
variable "random_string_allow_upper_case" {
  type        = bool
  description = "Allows upper case letters in the random string to be created"
  default     = false
}
variable "random_string_allow_numbers" {
  type        = bool
  description = "Allows numbers in the random string to be created"
  default     = false
}
