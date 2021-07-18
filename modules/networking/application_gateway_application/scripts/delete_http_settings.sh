
echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME} poolname: ${NAME}"

az network application-gateway http-settings delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
