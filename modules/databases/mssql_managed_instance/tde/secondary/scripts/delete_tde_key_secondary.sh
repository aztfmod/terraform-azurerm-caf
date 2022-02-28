#!/bin/bash

az keyvault key delete --name ${KEY_NAME} --vault-name ${KEYVAULT_NAME}
echo "Deleted ${KEY_NAME} key from keyvault ${KEYVAULT_NAME}"