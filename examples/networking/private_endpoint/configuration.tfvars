
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

name = "stgtest"

resource_group_name = "my-rg"
location            = "australiaeast"

subnet_id = "/subscriptions/.../some/subnet/id"

settings = {
  private_service_connection = {
    name                 = "stgtest"
    is_manual_connection = false
    subresource_names    = ["blob"]
  }

  ip_configuration = {
    name               = "pep-name"
    private_ip_address = "192.168.1.10"
    subresource_name   = "Blob"
    member_name        = "Blob"
  }
}
