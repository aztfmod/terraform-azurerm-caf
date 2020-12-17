
# Register Azure FrontDoor in the directory.
#
resource "null_resource" "front_door_service_principal" {

  provisioner "local-exec" {
    command     = "az ad sp create --id 'ad0e1c7e-6d38-4ba4-9efd-0bc77ba9f037'"
    interpreter = ["/bin/sh"]
    on_failure  = continue
  }
}
