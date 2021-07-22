
echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME}"

az network application-gateway http-listener delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
