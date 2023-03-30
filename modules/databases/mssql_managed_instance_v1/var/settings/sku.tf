variable "sku" {
  description = <<DESC
  Set the sku object with the following structure:

  sku = {
    name     = "GB_Gen5"
  }

  DESC

  type = object(
    {
      name = string
    }
  )


}
output "sku" {
  value = var.sku
}
#