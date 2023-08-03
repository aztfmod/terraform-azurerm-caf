#!/bin/bash

az keyvault key restore --file ./temp_backup.keybackup --vault-name ${KEYVAULT_NAME}
echo "Primary TDE Key restored to ${KEYVAULT_NAME}"

