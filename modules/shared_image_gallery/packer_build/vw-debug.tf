resource "null_resource" "debug" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "echo $VARIABLE1 >> image_definitions_debug.json; echo $VARIABLE2 >> image_definitions_debug.json; cat image_definitions_debug.json"
    environment = {
      VARIABLE1 = jsonencode(local.managed_identity)
      VARIABLE2 = jsonencode(var.managed_identities)
    }
  }
}
