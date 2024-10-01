variable "project_name" {
  description = "The name of the Dev Center project."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Dev Center project."
  type        = string
}

variable "location" {
  description = "The Azure region where the Dev Center project will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
