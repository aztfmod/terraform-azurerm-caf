
echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME} name: ${NAME}"

case "${RESOURCE}" in
    BACKENDPOOL)       
        az network application-gateway address-pool delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    HTTPSETTINGS)
        az network application-gateway http-settings delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    HTTPLISTENER)
        az network application-gateway http-listener delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    REQUESTROUTINGRULE)
        az network application-gateway rule delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
esac