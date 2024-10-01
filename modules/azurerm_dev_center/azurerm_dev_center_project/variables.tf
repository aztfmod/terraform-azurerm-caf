variable "project_name" {
  description = "The name of the Dev Center project."
  type        = string
}

variable "location" {
  description = "The location of the Dev Center project."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Dev Center project."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
