# This configuration demonstrates multiple implementations
# 1- OS Windows and Linux
# 2- instantiate container based on for_each, count or both
#

container_groups = {
  github_private_image = {
    name               = "github-private-image"
    region             = "region1"
    resource_group_key = "rg1"
    ip_address_type    = "Public"
    os_type            = "Linux"
    restart_policy     = "Always" // Possible values are 'Always'(default) 'Never' 'OnFailure'

    containers = {
      github_private_image = {
        name   = "github-private-image"
        image  = "ghcr.io/my_org/github-private-image:latest"
        cpu    = "0.5"
        memory = "1.5"

        ports = {
          80 = {
            port     = 80
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
            resource_key  = "github_private_image"
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
        "github_private_image"
      ]
    } // identity

    image_registry_credentials = {            # Max 1 image registry credential per container
      ghcr = {                                # To be able to pull container from private repo
        keyvault_key        = "secrets"       # keyvault key used in dynamic secrets
        username_secret_key = "ghcr_username" # dynamic secret for github username
        password_secret_key = "ghcr_password" # dynamic secret for github PAT-token
        server              = "ghcr.io"
      }
      #      docker_hub = {
      #        username = "my_username"
      #        password = "HUB_PAT"
      #        server = "index.docker.io"
      #      }
    } //image_registry_credentials
  }   //github_private_image
}

