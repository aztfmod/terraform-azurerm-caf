# #
# # Workaround until
# #

# data external deleted_secrets {
#   for_each = var.settings

#   program = [
#     "bash",
#     "-c",
#     format(
#       "az keyvault secret list-deleted --vault-name '%s' --query \"[?name=='%s'].{recoveryId: recoveryId}\" -o json | jq -rce '.[0] // {}'",
#       var.keyvault.name,
#       each.value.secret_name
#     )
#   ]
# }

# locals {
#   deleted_secrets = data.external.deleted_secrets
# }

# data external purge_secret {
#   depends_on = [data.external.deleted_secrets]
#   for_each   = var.settings

#   program = [
#     "bash",
#     "-c",
#     try(format("az keyvault secret purge --id %s -o json | jq -rce '. // {}'", local.deleted_secrets[each.key].result.recovery), "jq -nr '{}'")
#   ]
# }
