#Tflint config file
config {
  call_module_type = "all"
  force = false
  disabled_by_default = false
}

# Adds azurerm plugin
plugin "azurerm" {
    enabled = true
    version = "0.25.1"
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# Will be enabled progressively as we add more types
rule "terraform_typed_variables" {
  enabled = false
}