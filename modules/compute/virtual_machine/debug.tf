resource "null_resource" "debug" {
  provisioner "local-exec" {
    command = "echo $VARIABLE1 > debug.txt ; echo $VARIABLE2 >> debug.txt ; echo $VARIABLE3 >> debug.txt"
    environment = {
        VARIABLE1 = jsonencode(var.vnets)
        VARIABLE2 = jsonencode(var.client_config)
        VARIABLE3 = jsonencode(var.settings)
    }
  }
}