# Cloud Adoption Framework for Azure - Terraform module examples

The Cloud Adoption Framework for Azure - Terraform module can be used to deployed all components of CAF and compose those components together. It allows you to create complex architectures and composition relying on community contributions and proven patterns. You can leverage this module within a CAF landing zone, or straight from the Terraform registry.

## Deploying examples with Terraform

You can instantiate this module directly using the following syntax:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.4.2"
  # insert the 7 required variables here
}
```

### Compose your minimal example

A minimal example could be:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.4.2"

  global_settings = var.global_settings
  resource_groups = var.resource_groups
  keyvaults       = var.keyvaults

  compute = {
    virtual_machines = var.virtual_machines
  }

  networking = {
    public_ip_addresses = var.public_ip_addresses
    vnets               = var.vnets
  }
}
```

You can [find here a minimal example](./standalone.md)

### Run all the examples in this library

The current folder contains an example of module with the whole features set of the module, to run all the examples in the subfolders. You can leverage it the following way:

```bash
cd /tf/caf/examples
az login
terraform init
terraform plan -var-file <path to your variable file>
terraform apply -var-file <path to your variable file>
terraform destroy -var-file <path to your variable file>
```

## Deploying examples within a landing zone

To get started with the deployment within rover, follow the steps:

### 1. Log in the subscription with the rover

```bash
rover login
### you can alternatively specify the tenant space and subscription ID on command line arguments:
rover login --tenant <tenant_name>.onmicrosoft.com -s <subscription_id>
```

### 2. Deploy the basic launchpad

```bash
rover -lz /tf/caf/landingzones/caf_launchpad \
-launchpad \
-var-folder /tf/caf/landingzones/caf_launchpad/scenario/100 \
-a apply
```

### 3. Test your example

```bash
rover -lz /tf/caf/landingzones/caf_example \
-var-folder /tf/caf/examples/<path of the example> \
-a plan|apply
```
