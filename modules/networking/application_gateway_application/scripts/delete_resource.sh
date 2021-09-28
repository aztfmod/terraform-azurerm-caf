
echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME} name: ${NAME}"

case "${RESOURCE}" in
    BACKENDPOOL)
        execute_with_backoff az network application-gateway address-pool delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    HTTPSETTINGS)
        execute_with_backoff az network application-gateway http-settings delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    HTTPLISTENER)
        execute_with_backoff az network application-gateway http-listener delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    REQUESTROUTINGRULE)
        execute_with_backoff az network application-gateway rule delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    SSLCERT)
        execute_with_backoff az network application-gateway ssl-cert delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    ROOTCERT)
        execute_with_backoff az network application-gateway root-cert delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    PATHMAP)
        execute_with_backoff az network application-gateway url-path-map delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
    PATHRULE)
        execute_with_backoff az network application-gateway url-path-map rule delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} --path-map-name ${PATHMAPNAME} -n ${NAME}
        ;;
esac

#
# Execute a command and re-execute it with a backoff retry logic. This is mainly to handle throttling situations in CI
#
function execute_with_backoff {
  local max_attempts=${ATTEMPTS-5}
  local timeout=${TIMEOUT-20}
  local attempt=0
  local exitCode=0

  while [[ $attempt < $max_attempts ]]
  do
    set +e
    "$@"
    exitCode=$?
    set -e

    if [[ $exitCode == 0 ]]
    then
      break
    fi

    echo "Failure! Return code ${exitCode} - Retrying in $timeout.." 1>&2
    sleep $timeout
    attempt=$(( attempt + 1 ))
    timeout=$(( timeout * 2 ))
  done

  if [[ $exitCode != 0 ]]
  then
    echo "Hit the max retry count ($@)" 1>&2
  fi

  return $exitCode
}