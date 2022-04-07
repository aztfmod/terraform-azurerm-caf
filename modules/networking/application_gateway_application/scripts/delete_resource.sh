
echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME} name: ${NAME}"

#
# Execute a command and re-execute it with a backoff retry logic. This is mainly to handle throttling situations in CI
#
function execute_with_backoff {
  local max_attempts=${ATTEMPTS-5}
  local timeout=${TIMEOUT-20}
  local attempt=0
  local exitCode=0
  local API_VERSION="2021-05-01"
  local FILE=$HOME/$APPLICATION_GATEWAY_NAME.tmp

  while [[ $attempt < $max_attempts ]]
  do
    STATUS=$(az rest --method GET --url $APPLICATION_GATEWAY_ID?api-version=$API_VERSION --query "{status:properties.provisioningState}" -o tsv)
    echo "starting"
    while [[ "$STATUS" != "Succeeded" ]]
    do
        echo "waiting status to be succeeded"
        sleep 10
        STATUS=$(az rest --method GET --url $APPLICATION_GATEWAY_ID?api-version=$API_VERSION --query "{status:properties.provisioningState}" -o tsv)
        if [[ "$STATUS" == "Succeeded" ]]
        then
          break
        fi
    done

    if [[ ! -f "$FILE" ]]
    then
      echo "creating semaphore"
      touch "$FILE"
    else
      echo "waiting semaphore to be removed"
      while [[ -f "$FILE" ]]
      do
          sleep 10
          if [[ ! -f "$FILE" ]]
          then
               echo "creating semaphore"
              touch "$FILE"
              break
          fi
      done
    fi
    echo "running command"

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

  sleep 10
  rm -rf "$FILE"
  echo "done"

  if [[ $exitCode != 0 ]]
  then
    echo "Hit the max retry count ($@)" 1>&2
  fi

  return $exitCode
}

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
    PROBE)
        execute_with_backoff az network application-gateway probe delete -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME}
        ;;
esac