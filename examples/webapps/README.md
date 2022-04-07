# Azure Web Apps

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```

Under the webapps category you can create the following resources, with their examples:

| Technology                    | Examples Directory                                                                                                        |
|-------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| Azure App Service             | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/webapps/appservice/)            |
| Azure App Service Environment | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/webapps/appservice-environment) |
| Azure Functions               | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/webapps/function_app)           |
