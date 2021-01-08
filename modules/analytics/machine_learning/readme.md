# Azure Machine learning workspace

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_machine_learning" {
  source  = "aztfmod/caf/azurerm//modules/analytics/machine_learning"
  version = "4.21.2"
  # insert the 10 required variables here
}
```
*** Location Allowed Values ***
```
        "australiaeast",
        "brazilsouth",
        "canadacentral",
        "centralus",
        "centraluseuap",
        "eastasia",
        "eastus",
        "eastus2",
        "francecentral",
        "japaneast",
        "koreacentral",
        "northcentralus",
        "northeurope",
        "southeastasia",
        "southcentralus",
        "uksouth",
        "westcentralus",
        "westus",
        "westus2",
        "westeurope"
```

*** VM Size Allowed Values ***
```
        "Standard_D1_v2",
        "Standard_D2_v2",
        "Standard_D3_v2",
        "Standard_D4_v2",
        "Standard_D11_v2",
        "Standard_D12_v2",
        "Standard_D13_v2",
        "Standard_D14_v2",
        "Standard_DS1_v2",
        "Standard_DS2_v2",
        "Standard_DS3_v2",
        "Standard_DS4_v2",
        "Standard_DS5_v2",
        "Standard_DS11_v2",
        "Standard_DS12_v2",
        "Standard_DS13_v2",
        "Standard_DS14_v2",
        "Standard_M8-2ms",
        "Standard_M8-4ms",
        "Standard_M8ms",
        "Standard_M16-4ms",
        "Standard_M16-8ms",
        "Standard_M16ms",
        "Standard_M32-8ms",
        "Standard_M32-16ms",
        "Standard_M32ls",
        "Standard_M32ms",
        "Standard_M32ts",
        "Standard_M64-16ms",
        "Standard_M64-32ms",
        "Standard_M64ls",
        "Standard_M64ms",
        "Standard_M64s",
        "Standard_M128-32ms",
        "Standard_M128-64ms",
        "Standard_M128ms",
        "Standard_M128s",
        "Standard_M64",
        "Standard_M64m",
        "Standard_M128",
        "Standard_M128m",
        "Standard_D1",
        "Standard_D2",
        "Standard_D3",
        "Standard_D4",
        "Standard_D11",
        "Standard_D12",
        "Standard_D13",
        "Standard_D14",
        "Standard_DS15_v2",
        "Standard_NV6",
        "Standard_NV12",
        "Standard_NV24",
        "Standard_F2s_v2",
        "Standard_F4s_v2",
        "Standard_F8s_v2",
        "Standard_F16s_v2",
        "Standard_F32s_v2",
        "Standard_F64s_v2",
        "Standard_F72s_v2",
        "Standard_NC6s_v3",
        "Standard_NC12s_v3",
        "Standard_NC24rs_v3",
        "Standard_NC24s_v3",
        "Standard_NC6",
        "Standard_NC12",
        "Standard_NC24",
        "Standard_NC24r",
        "Standard_ND6s",
        "Standard_ND12s",
        "Standard_ND24rs",
        "Standard_ND24s",
        "Standard_NC6s_v2",
        "Standard_NC12s_v2",
        "Standard_NC24rs_v2",
        "Standard_NC24s_v2",
        "Standard_ND40rs_v2",
        "Standard_NV12s_v3",
        "Standard_NV24s_v3",
        "Standard_NV48s_v3"
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_insights\_id | The ID of the App Insights to be used by the nachine learning workspace. | `string` | n/a | yes |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| keyvault\_id | The ID of the Key Vault to be used by the machine learning workspace. | `string` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | Configuration object for the machine learning workspace. | `any` | n/a | yes |
| storage\_account\_id | The ID of the Storage Account to be used by the nachine learning workspace. | `string` | n/a | yes |
| vnets | Virtual networks objects - contains all virtual networks that could potentially be used by the module. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Machine Learning Workspace. |
| identity | An identity block exports the following: - principal\_id: The (Client) ID of the Service Principal, -tenant\_id: The ID of the Tenant the Service Principal is assigned in. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->