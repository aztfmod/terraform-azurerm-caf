variable "dev_center_name" {
  description = "The name of the Dev Center."
  type        = string
}

variable "dev_box_definition_name" {
  description = "The name of the Dev Box Definition."
  type        = string
}

variable "image_reference" {
  description = "The image reference for the Dev Box Definition."
  type = object({
    offer     = string
    publisher = string
    sku       = string
    version   = string
  })
}

variable "os_storage_type" {
  description = "The OS storage type for the Dev Box Definition."
  type        = string
}

variable "description" {
  description = "The description of the Dev Box Definition."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
