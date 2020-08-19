
variable "prefix" {
    description = "(Optional) You can use a prefix to add to the list of resource groups you want to create"
}

variable "tags" {
    description = "(Required) map of tags for the deployment"
}

variable "ase_id" {
    description = "(Required) ASE Id for App Service Plan Hosting Environment"
}

variable "ase_name" {
    description = "(Required) ASE Id for App Service Plan Hosting Environment"
}

variable "resource_group_name" {
    
}

variable "resource_group_location" {
    
}

variable "app_service_plans" {}

variable "convention" {
    
}