
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
    SSLCERT)
        az network application-gateway ssl-cert delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    ROOTCERT)
        az network application-gateway root-cert delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    PATHMAP)
        az network application-gateway url-path-map delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    PATHRULE)
        az network application-gateway url-path-map rule delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} --path-map-name ${PATHMAPNAME} -n ${NAME}
        ;;
esac