variable "cdn_frontdoor_profile_id" {
  default = null
}

variable "settings" {
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}