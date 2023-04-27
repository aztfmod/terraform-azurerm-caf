# variable "preview_features" {
#   type = map(list(string))
#   default = {
#     "Microsoft.ContainerService" = [
#       "AKS-KedaPreview",
#       "AKS-VPAPreview"
#     ]
#   }
# }
locals {
  flat_preview_features = flatten([
    for ns, features in var.preview_features : [
      for feature in features : {
        full_name = "${ns}/${feature}"
        namespace = ns
        feature   = feature
      }
    ]
  ])
}

resource "null_resource" "register_feature_preview" {
  for_each = { for f in local.flat_preview_features : f.full_name => f }

  provisioner "local-exec" {
    command = <<EOT
      az feature register --namespace ${each.value.namespace} -n ${each.value.feature}
      while true; do
        feature_status=$(az feature show --namespace ${each.value.namespace} -n ${each.value.feature} --query "properties.state" -o tsv)
        if [ -n "$feature_status" ] && [ "$feature_status" = "Registered" ]; then
          break
        else
          echo "Waiting for feature registration to complete..."
          sleep 30
        fi
      done
    EOT
  }
}