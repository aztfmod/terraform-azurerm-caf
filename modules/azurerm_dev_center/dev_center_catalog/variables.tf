variable "dev_center_catalog_name" {
  description = "The name of the Dev Center Catalog."
  type        = string
}

variable "location" {
  description = "The location of the Dev Center Catalog."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Dev Center Catalog."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "global_settings" {
  description = "Global settings for naming conventions and other configurations."
  type = object({
    prefixes      = list(string)
    random_length = number
    passthrough   = bool
    use_slug      = bool
  })
}
