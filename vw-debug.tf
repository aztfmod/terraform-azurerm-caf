resource "null_resource" "debug" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "echo $VARIABLE2 >> debug.json; cat debug.json"
    environment = {
      VARIABLE2 = jsonencode(try(local.combined_objects_azuread_service_principals, ""))
    }
  }
}
