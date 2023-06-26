variable "identity" {
  description = <<DESC
  Set the identity object with the following structure:

  identity = {
    type     = "SystemAssignedGB_Gen5"
  }

  DESC

  type = object(
    {
      type = string
    }
  )


}
output "identity" {
  value = var.identity
}
#