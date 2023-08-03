variable "vcores" {
  description = "The number of vCores."
  default     = null
  type        = number
}
module "vcores_gen4" {
  source = "./gen4"
  count  = can(regex("Gen4", var.sku_name)) ? 1 : 0
  vcores = var.vcores
}
module "vcores_gen5" {
  source = "./gen5"
  count  = can(regex("Gen5", var.sku_name)) ? 1 : 0
  vcores = var.vcores
}
output "vcores" {
  value = try(
    module.vcores_gen4.0.vcores,
    module.vcores_gen5.0.vcores,
    var.vcores
  )
}