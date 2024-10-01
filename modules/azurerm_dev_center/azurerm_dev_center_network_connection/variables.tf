variable "network_connection_name" {
  description = "The name of the Network Connection."
  type        = string
}

variable "location" {
  description = "The location of the Network Connection."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Network Connection."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to which the Network Connection is associated."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the Network Connection."
  type        = string
}

variable "domain_username" {
  description = "The username for the domain."
  type        = string
}

variable "domain_password" {
  description = "The password for the domain."
  type        = string
  sensitive   = true
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
