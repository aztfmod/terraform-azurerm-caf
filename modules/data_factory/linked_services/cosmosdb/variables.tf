variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "Used for general parameter."
}
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Data Factory Linked Service."
}
variable "data_factory_id" {
  description = "(Required) The Data Factory ID in which to associate the Linked Service with. Changing this forces a new resource."
}
variable "account_endpoint" {
  description = " (Optional) The endpoint of the Azure CosmosDB account. Required if connection_string is unspecified."
}
variable "account_key" {
  description = "(Optional) The account key of the Azure Cosmos DB account. Required if connection_string is unspecified."
}