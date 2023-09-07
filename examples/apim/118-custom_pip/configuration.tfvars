global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    example = "apim/118-custom_pip"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}


api_management = {
  apim1 = {
    name   = "example-apim"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    publisher_name  = "My Company"
    publisher_email = "company@terraform.io"

    public_ip_address    = {
      key = "pip_1"
    }

    sku_name = "Developer_1"
    tags = {
      project = "demo"
    }
  }
}

public_ip_addresses = {
  pip_1 = {
    name                    = "pip-1"
    resource_group = {
      key = "rg1"
    }
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    domain_name_label       = "terraform-test-pip"
    zones                   = ["1"]
    idle_timeout_in_minutes = "4"
  }
}