variable "resource_group_name" {
  description = "The name of the resource group in which to create the network connection."
  type        = string
}

variable "location" {
  description = "The location/region where the network connection should be created."
  type        = string
}

variable "network_connection_name" {
  description = "The name of the network connection."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to which the network connection should be associated."
  type        = string
}

variable "domain_name" {
  description = "The domain name of the network connection."
  type        = string
}

variable "domain_username" {
  description = "The username for the domain of the network connection."
  type        = string
}

variable "domain_password" {
  description = "The password for the domain of the network connection."
  type        = string
}

variable "domain_ou" {
  description = "The organizational unit within the domain for the network connection."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the network connection."
  type        = map(string)
  default     = {}
}
