application_gateways = {
  agw_core = {
    resource_group_key = "core_services"
    name = "app-gateway"

    vnet_key   = "shared_spoke"
    subnet_key = "app-gateway-public"

    sku_name = "Standard_v2"
    sku_tier = "Standard_v2"
    capacity = {
      autoscale = {
        minimum_scale_unit = 1
        maximum_scale_unit = 2
      }
    }
    zones        = ["1"]
    enable_http2 = true

    identity = {
      managed_identity_keys = [
        "appgw_keyvault_certs"
      ]
    }

    front_end_ip_configurations = {
      public = {
        name          = "public"
        public_ip_key = "appgw_pip"
      }
      private = {
        name                          = "private"
        vnet_key                      = "shared_spoke"
        subnet_key                    = "app-gateway-public"
        subnet_cidr_index             = 0 # It is possible to have more than one cidr block per subnet
        private_ip_offset             = 4 # e.g. cidrhost(10.10.0.0/25,4) = 10.10.0.4 => AGW private IP address
        private_ip_address_allocation = "Static"
      }
    }

    front_end_ports = {
      80 = {
        name     = "http-80"
        port     = 80
        protocol = "Http"
      }
      443 = {
        name     = "https-443"
        port     = 443
        protocol = "Https"
      }
    }
    
    # This is the important block!
    # NOTE - This example does not provision a certificate in the vault.
    #        You can manually upload/generate one for your environment, then
    #        reference with keyvault_key or keyvault_id. Just ensure the appropriate
    #        role_assignment is provisioned for the AGW Managed Identity, and also the 
    #        Service Principal that the pipeline runs under.
    manual_certs_multiple_listeners = {
      wildcard_np_domain_com = {
        certificate_name = "wildcard-np-domain-com"
        keyvault_key     = "cert_kv"
        # keyvault_id = "/sub/a-b-c-d-e/rg/xyz"
      }
    }

  }
}
