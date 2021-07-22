#!/bin/bash

echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME}"

frontendip=$([ -z "${PUBLIC_IP}" ] && echo "" || echo "--frontend-ip ${PUBLIC_IP} ")
hostname=$([ -z "${HOST_NAME}" ] && echo "" || echo "--host-name ${HOST_NAME} ")
hostnames=$([ -z "${HOST_NAMES}" ] && echo "" || echo "--host-names ${HOST_NAMES} ")
sslcert=$([ -z "${SSL_CERT}" ] && echo "" || echo "--ssl-cert ${SSL_CERT} ")
wafpolicy=$([ -z "${WAF_POLICY}" ] && echo "" || echo "--waf-policy ${WAF_POLICY} ")

az network application-gateway http-listener create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} \
-n ${NAME} --frontend-port ${PORT} ${frontendip}${hostname}${hostnames}${sslcert}${wafpolicy}
