###########
# pre-reqs
# terraform login
# export TERRAFORM_CONFIG="$HOME/.terraform.d/credentials.tfrc.json"
##########
terraform {
  required_version = ">= 0.13"

}

# If you have the value handy you can add then here to be built into your TFC deployment otherwise your have to manually add them to TFC
# variable "tenantId" {
#   type        = string
#   description = "The name of the resources"
#   default     = ""
# }
# variable "arm_subscription_id" {
#   type        = string
#   description = "The name of the resources"
#   default     = ""
# }
# variable "arm_client_id" {
#   type        = string
#   description = "The name of the resources"
#   default     = ""
# }

# variable "arm_client_secret" {
#   type        = string
#   description = "The name of the resources"
#   default     = ""
# }

resource "random_pet" "name" {
  prefix = "CAF"
  length = 1
}

resource "tfe_organization" "caf-org" {
  name  = random_pet.name.id
  email = "admin@your-company.com"
}

resource "tfe_workspace" "landingzone_caf_foundations" {
  name         = "${random_pet.name.id}-landingzone_caf_foundations"
  organization = tfe_organization.caf-org.name
}

resource "tfe_variable" "ARM_SUBSCRIPTION_ID" {
  key          = "ARM_SUBSCRIPTION_ID"
  value        = var.arm_subscription_id
  category     = "env"
  workspace_id = tfe_workspace.landingzone_caf_foundations.id
  description  = "ARM_SUBSCRIPTION_ID"
}

resource "tfe_variable" "ARM_CLIENT_ID" {
  key          = "ARM_CLIENT_ID"
  value        = var.arm_client_id
  category     = "env"
  workspace_id = tfe_workspace.landingzone_caf_foundations.id
  description  = "ARM_CLIENT_ID"
}

resource "tfe_variable" "ARM_CLIENT_SECRET" {
  key          = "ARM_CLIENT_SECRET"
  value        = var.arm_client_secret
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.landingzone_caf_foundations.id
  description  = "ARM_CLIENT_SECRET"
}

resource "tfe_variable" "ARM_TENANT_ID" {
  key          = "ARM_TENANT_ID"
  value        = var.tenantId
  category     = "env"
  workspace_id = tfe_workspace.landingzone_caf_foundations.id
  description  = "ARM_TENANT_ID"
}
resource  "null_resource" "backend_file" {
  depends_on = [tfe_workspace.landingzone_caf_foundations]
  provisioner "local-exec" {
  command =  "echo  workspaces '{' name = \\\"${tfe_workspace.landingzone_caf_foundations.name}\\\" '}' >> ../landingzone_caf_foundations/backend.hcl"
  }
  provisioner "local-exec" {
  command =  "echo hostname = \\\"app.terraform.io\\\" >> ../landingzone_caf_foundations/backend.hcl"
  }
  provisioner "local-exec" {
  command =  "echo  organization = \\\"${tfe_organization.caf-org.name}\\\" >> ../landingzone_caf_foundations/backend.hcl"
  }
}

resource  "null_resource" "remote_init" {
  depends_on = [null_resource.backend_file]
  provisioner "local-exec" {
  working_dir = "../landingzone_caf_foundations/"
  command =  "terraform init -backend-config=backend.hcl"
  }
}

resource "tfe_workspace" "landingzone_hub_spoke" {
  name         = "${random_pet.name.id}-landingzone_hub_spoke"
  organization = tfe_organization.caf-org.name
}

resource "tfe_variable" "ARM_SUBSCRIPTION_ID_1" {
  key          = "ARM_SUBSCRIPTION_ID"
  value        = var.arm_subscription_id
  category     = "env"
  workspace_id = tfe_workspace.landingzone_hub_spoke.id
  description  = "ARM_SUBSCRIPTION_ID"
}

resource "tfe_variable" "ARM_CLIENT_ID_1" {
  key          = "ARM_CLIENT_ID"
  value        = var.arm_client_id
  category     = "env"
  workspace_id = tfe_workspace.landingzone_hub_spoke.id
  description  = "ARM_CLIENT_ID"
}

resource "tfe_variable" "ARM_CLIENT_SECRET_1" {
  key          = "ARM_CLIENT_SECRET"
  value        = var.arm_client_secret
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.landingzone_hub_spoke.id
  description  = "ARM_CLIENT_SECRET"
}

resource "tfe_variable" "ARM_TENANT_ID_1" {
  key          = "ARM_TENANT_ID"
  value        = var.tenantId
  category     = "env"
  workspace_id = tfe_workspace.landingzone_hub_spoke.id
  description  = "ARM_TENANT_ID"
}
resource  "null_resource" "backend_file_1" {
  depends_on = [tfe_workspace.landingzone_hub_spoke]
  provisioner "local-exec" {
  command =  "echo  workspaces '{' name = \\\"${tfe_workspace.landingzone_hub_spoke.name}\\\" '}' >> ../landingzone_hub_spoke/backend.hcl"
  }
  provisioner "local-exec" {
  command =  "echo hostname = \\\"app.terraform.io\\\" >> ../landingzone_hub_spoke/backend.hcl"
  }
  provisioner "local-exec" {
  command =  "echo  organization = \\\"${tfe_organization.caf-org.name}\\\" >> ../landingzone_hub_spoke/backend.hcl"
  }
}

resource  "null_resource" "backend_auto_file" {
  depends_on = [tfe_workspace.landingzone_caf_foundations]
  provisioner "local-exec" {
  command =  "echo  workspaces = \\\"${tfe_workspace.landingzone_caf_foundations.name}\\\" >> ../landingzone_hub_spoke/backend.auto.tfvars"
  }
  provisioner "local-exec" {
  command =  "echo  organization = \\\"${tfe_organization.caf-org.name}\\\" >> ../landingzone_hub_spoke/backend.auto.tfvars"
  }
}

resource  "null_resource" "remote_init_1" {
  depends_on = [null_resource.backend_file_1]
  provisioner "local-exec" {
  working_dir = "../landingzone_hub_spoke/"
  command =  "terraform init -backend-config=backend.hcl"
  }
}

output "user_instructions" {
  value = <<README

 your org name                                        = ${tfe_organization.caf-org.name}
 your workspace for creating your foundations is      = ${tfe_workspace.landingzone_caf_foundations.name}
 your workspace for creating your hub and spoke       = ${tfe_workspace.landingzone_hub_spoke.name}
# Run these commands in order:
#    cd ../deploy_CAF
#then
#    terraform apply
README
}