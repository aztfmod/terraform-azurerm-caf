variable "resource_group_name" {
  description = "The name of the resource group in which to create the Dev Center."
  type        = string
}

variable "location" {
  description = "The location/region where the Dev Center should be created."
  type        = string
}

variable "dev_center_name" {
  description = "The name of the Dev Center."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
