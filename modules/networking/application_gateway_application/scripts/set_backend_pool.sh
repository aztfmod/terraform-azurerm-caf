#!/bin/bash

echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME} poolname: ${NAME} servers: ${ADDRESS_POOL}"

servers=$([ -z "${ADDRESS_POOL}" ] && echo "" || echo "--servers ${ADDRESS_POOL}")

az network application-gateway address-pool create -g ${RG_NAME} \
    --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME} ${servers}
