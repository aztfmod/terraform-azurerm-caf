

echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME}"


protocol=$([ -z "${PROTOCOL}" ] && echo "" || echo "--protocol ${PROTOCOL} ")
cba=$([ -z "${COOKIE_BASED_AFFINITY}" ] && echo "" || echo "--cookie-based-affinity ${COOKIE_BASED_AFFINITY} ")
timeout=$([ -z "${TIMEOUT}" ] && echo "" || echo "--timeout ${TIMEOUT} ")
affinitycookiename =$([ -z "${AFFINITY_COOKIE_NAME}" ] && echo "" || echo "--affinity-cookie-name ${AFFINITY_COOKIE_NAME} ")
authcerts=$([ -z "${AUTH_CERTS}" ] && echo "" || echo "--auth-certs ${AUTH_CERTS} ")
connectiondrainingtimeout=$([ -z "${CONNECTION_DRAINING_TIMEOUT}" ] && echo "" || echo "--connection-draining-timeout ${CONNECTION_DRAINING_TIMEOUT} ")
enableprobe=$([ -z "${ENABLE_PROBE}" ] && echo "" || echo "--enable-probe ${ENABLE_PROBE} ")
hostname=$([ -z "${HOST_NAME}" ] && echo "" || echo "--host-name ${HOST_NAME} ")
hostnamefrombackendpool=$([ -z "${HOST_NAME_FROM_BACKEND_POOL}" ] && echo "" || echo "--host-name-from-backend-pool ${HOST_NAME_FROM_BACKEND_POOL} ")
path=$([ -z "${PATH}" ] && echo "" || echo "--path ${PATH} ")
probe=$([ -z "${PROBE}" ] && echo "" || echo "--probe ${PROBE} ")
rootcerts=$([ -z "${ROOT_CERTS}" ] && echo "" || echo "--root-certs ${ROOT_CERTS} ")


az network application-gateway http-settings create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME} --port ${PORT} \
${protocol}${cba}${timeout}${affinitycookiename}${authcerts}${connectiondrainingtimeout}${enableprobe}${hostname}${hostnamefrombackendpool}${path}${probe}${rootcerts}

 