resource "null_resource" "debug" {
  provisioner "local-exec" {
    command = "echo $VARIABLE1 > debug.json ; echo $VARIABLE2 >> debug.json ; echo $VARIABLE3 >> debug.json"
    environment = {
      VARIABLE1 = jsonencode(local.combined_objects_networking)
      VARIABLE2 = jsonencode(local.client_config)
      VARIABLE3 = jsonencode(local.compute.virtual_machines)
    }
  }
}
