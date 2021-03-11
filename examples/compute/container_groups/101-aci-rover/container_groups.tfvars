# This configuration demonstrates multiple implementations
# 1- OS Windows and Linux
# 2- instantiate container based on for_each, count or both
#

container_groups = {
  nginx = {
    name               = "nginx"
    region             = "region1"
    resource_group_key = "rg1"
    ip_address_type    = "Public"
    os_type            = "Linux"
    restart_policy     = "Never" // Possible values are 'Always'(default) 'Never' 'OnFailure'

    containers = {
      nginx = {
        name   = "nginx"
        image  = "nginx"
        cpu    = "0.5"
        memory = "1.5"

        ports = {
          22 = {
            port     = 22
            protocol = "TCP"
          }
        }

        # for demo purposes
        environment_variables = {
          URL = "https://www.microsoft.com"
        }
        secure_environment_variables = {
          TOKEN = "token from tfvars"
        }
        environment_variables_from_resources = {
          AGENT_KEYVAULT_NAME = {
            output_key    = "keyvaults"
            resource_key  = "secrets"
            attribute_key = "name"
          }
          MSI_ID = {
            output_key    = "managed_identities"
            resource_key  = "nginx"
            attribute_key = "id"
          }
        }
      }

    } //containers

    tags = {
      environment = "testing"
    }

    identity = {
      type = "UserAssigned" // Possible options are 'SystemAssigned, UserAssigned' 'SystemAssigned' or 'UserAssigned'
      managed_identity_keys = [
        "nginx"
      ]
    } // identity

  } //nginx

  httpd = {
    name               = "httpd"
    region             = "region1"
    resource_group_key = "rg1"
    ip_address_type    = "Public"
    os_type            = "Linux"
    restart_policy     = "Never" // Possible values are 'Always'(default) 'Never' 'OnFailure'

    containers = {

      # You can also deploy the name container multiple times based on the count number
      httpd = {
        name   = "httpd"
        image  = "httpd"
        cpu    = "0.5"
        memory = "0.3"

        ports = {
          80 = {
            port     = 80
            protocol = "TCP"
          }
        }
      }

    } //containers

    tags = {
      environment = "testing"
    }

  } //httpd

}
