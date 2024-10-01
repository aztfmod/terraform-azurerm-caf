variable "resource_group_name" {
  description = "The name of the resource group in which to create the environment type."
  type        = string
}

variable "dev_center_name" {
  description = "The name of the Dev Center."
  type        = string
}

variable "environment_type_name" {
  description = "The name of the environment type."
  type        = string
}

variable "description" {
  description = "The description of the environment type."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
