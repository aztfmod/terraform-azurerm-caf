resource "null_resource" "debug" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "echo $VARIABLE1 >> debug.json; cat debug.json"
    environment = {
      VARIABLE1 = jsonencode(try(var.azuread_service_principals, ""))
    }
  }
}
