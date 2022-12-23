azuread_applications = {
  app1 = {
    application_name     = "example"
    identifier_uris  = ["api://test-external-example-app"]
    logo_image       = "./azuread_graph/107-azuread_applications/img/logo.png"
    sign_in_audience = "AzureADMultipleOrgs"

    api = {
      mapped_claims_enabled          = true
      requested_access_token_version = 2


      oauth2_permission_scopes = [
        {
          admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
          admin_consent_display_name = "Access example"
          enabled                    = true
          id                         = "96183846-204b-4b43-82e1-5d2222eb4b9b"
          type                       = "User"
          user_consent_description   = "Allow the application to access example on your behalf."
          user_consent_display_name  = "Access example"
          value                      = "user_impersonation"
        },
        {
          admin_consent_description  = "Administer the example application"
          admin_consent_display_name = "Administer"
          enabled                    = true
          id                         = "be98fa3e-ab5b-4b11-83d9-04ba2b7946bc"
          type                       = "Admin"
          value                      = "administer"
        }
      ]
    }

    app_roles = [
      {
        allowed_member_types = ["User", "Application"]
        description          = "Admins can manage roles and perform all task actions"
        display_name         = "Admin"
        enabled              = true
        id                   = "1b19509b-32b1-4e9f-b71d-4992aa991967"
        value                = "admin"
      },
      {
        allowed_member_types = ["User"]
        description          = "ReadOnly roles have limited query access"
        display_name         = "ReadOnly"
        enabled              = true
        id                   = "497406e4-012a-4267-bf18-45a1cb148a01"
        value                = "User"
      }
    ]

    feature_tags = {
      enterprise = true
      gallery    = true
    }

    optional_claims = {
      access_tokens = [
        {
          name = "myclaim"
        },
        {
          name = "otherclaim"
        }
      ]

      id_tokens = [
        {
          name                  = "userclaim"
          source                = "user"
          essential             = true
          additional_properties = ["emit_as_roles"]
        }
      ]

      saml2_tokens = [
        {
          name = "samlexample"
        }
      ]
    }

    required_resources_access = [
      {
        resource_app = {
          id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
        }
        resources_access = [
          {
            id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
            type = "Role"
          },
          {
            id   = "b4e74841-8e56-480b-be8b-910348b18b4c" # User.ReadWrite
            type = "Scope"
          }
        ]
      },
      {
        resource_app = {
          id = "c5393580-f805-4401-95e8-94b7a6ef2fc2" # Office 365 Management
        }
        resources_access = [ 
          {
            id   = "594c1fb6-4f81-4475-ae41-0c394909246c" # ActivityFeed.Read
            type = "Role"
          }
        ]
      }
    ]

    single_page_application = {
      redirect_uris = [
        "https://example.com/TokenCallback"        
      ]
    }

    web = {
      homepage_url  = "https://app.example.net"
      logout_url    = "https://app.example.net/logout"
      redirect_uris = ["https://app.example.net/account"]

      implicit_grant = {
        access_token_issuance_enabled = true
        id_token_issuance_enabled     = true
      }
    }
  }
}

azuread_application_passwords = {
    pass1 = {
      application_object = {
        key = "app1"
      }
      display_name = "example-pass"
      description  = "application password example"      
    } 
  }