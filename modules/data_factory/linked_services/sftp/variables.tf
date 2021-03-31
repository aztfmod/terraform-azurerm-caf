variable "name" {
  description = "(Required) Specifies the name of the Data Factory Linked Service. Changing this forces a new resource to be created. Must be globally unique."
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Data Factory Linked Service. Changing this forces a new resource"
}

variable "data_factory_name" {
  description = "(Required) The Data Factory name in which to associate the Linked Service with. Changing this forces a new resource."
}

variable "description" {
  description = "(Optional) The description for the Data Factory Linked Service."
}

variable "integration_runtime_name" {
  description = "(Optional) The integration runtime reference to associate with the Data Factory Linked Service."
}

variable "annotations" {
  description = "(Optional) List of tags that can be used for describing the Data Factory Linked Service."
}

variable "parameters" {
  description = "(Optional) A map of parameters to associate with the Data Factory Linked Service."
}

variable "additional_properties" {
  description = "(Optional) A map of additional properties to associate with the Data Factory Linked Service."
}

variable "authentication_type" {
  description = "(Required) The type of authentication used to connect to the web table source. Valid options are Anonymous, Basic and ClientCertificate."
}

variable "host" {
  description = "(Required) The SFTP server hostname."
}

variable "port" {
  description = "(Required) The TCP port number that the SFTP server uses to lsiten for client connection. Default value is 22."
}

variable "username" {
  description = "(Required) The username used to log on to the SFTP server."
}

variable "password" {
  description = "(Required) Password to logon to the SFTP Server for Basic Authentication."
}