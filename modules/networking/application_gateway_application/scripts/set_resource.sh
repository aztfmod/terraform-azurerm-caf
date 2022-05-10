#!/bin/bash

echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME} name: ${NAME} resource: ${RESOURCE}"

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
        servers=$([ -z "${ADDRESS_POOL}" ] && echo "" || echo "--servers ${ADDRESS_POOL} ")

        execute_with_backoff az network application-gateway address-pool create -g ${RG_NAME} \
            --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME} ${servers}
        ;;
    HTTPSETTINGS)
        protocol=$([ -z "${PROTOCOL}" ] && echo "" || echo "--protocol ${PROTOCOL} ")
        cba=$([ -z "${COOKIE_BASED_AFFINITY}" ] && echo "" || echo "--cookie-based-affinity ${COOKIE_BASED_AFFINITY} ")
        timeout=$([ -z "${TIMEOUT}" ] && echo "" || echo "--timeout ${TIMEOUT} ")
        affinitycookiename=$([ -z "${AFFINITY_COOKIE_NAME}" ] && echo "" || echo "--affinity-cookie-name ${AFFINITY_COOKIE_NAME} ")
        authcerts=$([ -z "${AUTH_CERTS}" ] && echo "" || echo "--auth-certs ${AUTH_CERTS} ")
        connectiondrainingtimeout=$([ -z "${CONNECTION_DRAINING_TIMEOUT}" ] && echo "" || echo "--connection-draining-timeout ${CONNECTION_DRAINING_TIMEOUT} ")
        enableprobe=$([ -z "${ENABLE_PROBE}" ] && echo "" || echo "--enable-probe ${ENABLE_PROBE} ")
        hostname=$([ -z "${HOST_NAME}" ] && echo "" || echo "--host-name ${HOST_NAME} ")
        hostnamefrombackendpool=$([ -z "${HOST_NAME_FROM_BACKEND_POOL}" ] && echo "" || echo "--host-name-from-backend-pool ${HOST_NAME_FROM_BACKEND_POOL} ")
        path=$([ -z "${OVERRIDE_PATH}" ] && echo "" || echo "--path ${OVERRIDE_PATH} ")
        probe=$([ -z "${PROBE}" ] && echo "" || echo "--probe ${PROBE} ")
        rootcerts=$([ -z "${ROOT_CERTS}" ] && echo "" || echo "--root-certs ${ROOT_CERTS} ")

        execute_with_backoff az network application-gateway http-settings create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME} --port ${PORT} \
        ${protocol}${cba}${timeout}${affinitycookiename}${authcerts}${connectiondrainingtimeout}${enableprobe}${hostname}${hostnamefrombackendpool}${path}${probe}${rootcerts}
        ;;
    HTTPLISTENER)
        frontendip=$([ -z "${PUBLIC_IP}" ] && echo "" || echo "--frontend-ip ${PUBLIC_IP} ")
        hostname=$([ -z "${HOST_NAME}" ] && echo "" || echo "--host-name ${HOST_NAME} ")
        hostnames=$([ -z "${HOST_NAMES}" ] && echo "" || echo "--host-names ${HOST_NAMES} ")
        sslcert=$([ -z "${SSL_CERT}" ] && echo "" || echo "--ssl-cert ${SSL_CERT} ")
        wafpolicy=$([ -z "${WAF_POLICY}" ] && echo "" || echo "--waf-policy ${WAF_POLICY} ")

        execute_with_backoff az network application-gateway http-listener create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} \
        -n ${NAME} --frontend-port ${PORT} ${frontendip}${hostname}${hostnames}${sslcert}${wafpolicy}
        ;;
    REQUESTROUTINGRULE)
        listener=$([ -z "${LISTENER}" ] && echo "" || echo "--http-listener ${LISTENER} ")
        addresspool=$([ -z "${ADDRESS_POOL}" ] && echo "" || echo "--address-pool ${ADDRESS_POOL} ")
        httpsettings=$([ -z "${HTTP_SETTINGS}" ] && echo "" || echo "--http-settings ${HTTP_SETTINGS} ")
        priority=$([ -z "${PRIORITY}" ] && echo "" || echo "--priority ${PRIORITY} ")
        redirectconfig=$([ -z "${REDIRECT_CONFIG}" ] && echo "" || echo "--redirect-config ${REDIRECT_CONFIG} ")
        rewriteruleset=$([ -z "${REWRITE_RULE_SET}" ] && echo "" || echo "--rewrite-rule-set ${REWRITE_RULE_SET} ")
        ruletype=$([ -z "${RULE_TYPE}" ] && echo "" || echo "--rule-type ${RULE_TYPE} ")
        urlpathmap=$([ -z "${URL_PATH_MAP}" ] && echo "" || echo "--url-path-map ${URL_PATH_MAP} ")

        execute_with_backoff az network application-gateway rule create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} \
        -n ${NAME} ${listener}${addresspool}${httpsettings}${priority}${redirectconfig}${rewriteruleset}${ruletype}${urlpathmap}
        ;;
    SSLCERT)
        certfile=$([ -z "${CERT_FILE}" ] && echo "" || echo "--cert-file ${CERT_FILE} ")
        certpassword=$([ -z "${CERT_PASSWORD}" ] && echo "" || echo "--cert-password ${CERT_PASSWORD} ")
        keyvaultsecretid=$([ -z "${KEY_VAULT_SECRET_ID}" ] && echo "" || echo "--key-vault-secret-id ${KEY_VAULT_SECRET_ID} ")

        execute_with_backoff az network application-gateway ssl-cert create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} \
        -n ${NAME} ${certfile}${certpassword}${keyvaultsecretid}
        ;;
    ROOTCERT)
        certfile=$([ -z "${CERT_FILE}" ] && echo "" || echo "--cert-file ${CERT_FILE} ")
        keyvaultsecretid=$([ -z "${KEY_VAULT_SECRET_ID}" ] && echo "" || echo "--key-vault-secret-id ${KEY_VAULT_SECRET_ID} ")

        execute_with_backoff az network application-gateway root-cert create --gateway-name ${APPLICATION_GATEWAY_NAME} --resource-group ${RG_NAME} \
         --name ${NAME} ${certfile}${keyvaultsecretid}
        ;;
    PATHMAP)
        addresspool=$([ -z "${ADDRESS_POOL}" ] && echo "" || echo "--address-pool ${ADDRESS_POOL} ")
        httpsettings=$([ -z "${HTTP_SETTINGS}" ] && echo "" || echo "--http-settings ${HTTP_SETTINGS} ")
        redirectconfig=$([ -z "${REDIRECT_CONFIG}" ] && echo "" || echo "--redirect-config ${REDIRECT_CONFIG} ")
        rewriteruleset=$([ -z "${REWRITE_RULE_SET}" ] && echo "" || echo "--rewrite-rule-set ${REWRITE_RULE_SET} ")
        rulename=$([ -z "${RULE_NAME}" ] && echo "" || echo "--rule-name ${RULE_NAME} ")
        wafpolicy=$([ -z "${WAF_POLICY}" ] && echo "" || echo "--waf-policy ${WAF_POLICY} ")

        execute_with_backoff az network application-gateway url-path-map create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} \
            -n ${NAME} --paths ${PATHS} ${addresspool}${httpsettings}${redirectconfig}${rewriteruleset}${rulename}${wafpolicy}
        ;;
    PATHRULE)
        addresspool=$([ -z "${ADDRESS_POOL}" ] && echo "" || echo "--address-pool ${ADDRESS_POOL} ")
        httpsettings=$([ -z "${HTTP_SETTINGS}" ] && echo "" || echo "--http-settings ${HTTP_SETTINGS} ")
        redirectconfig=$([ -z "${REDIRECT_CONFIG}" ] && echo "" || echo "--redirect-config ${REDIRECT_CONFIG} ")
        rewriteruleset=$([ -z "${REWRITE_RULE_SET}" ] && echo "" || echo "--rewrite-rule-set ${REWRITE_RULE_SET} ")
        wafpolicy=$([ -z "${WAF_POLICY}" ] && echo "" || echo "--waf-policy ${WAF_POLICY} ")

        execute_with_backoff az network application-gateway url-path-map rule create -g ${RG_NAME} \
            --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME} --path-map-name ${PATHMAPNAME} \
            --paths ${PATHS} ${addresspool}${httpsettings}${redirectconfig}${rewriteruleset}${wafpolicy}
        ;;
    PROBE)
        host=$([ -z "${HOST}" ] && echo "" || echo "--host ${HOST} ")
        hostnamefromhttpsettings=$([ -z "${HOST_NAME_FROM_HTTP_SETTINGS}" ] && echo "" || echo "--host-name-from-http-settings ${HOST_NAME_FROM_HTTP_SETTINGS} ")
        interval=$([ -z "${INTERVAL}" ] && echo "" || echo "--interval ${INTERVAL} ")
        matchbody=$([ -z "${MATCH_BODY}" ] && echo "" || echo "--match-body ${MATCH_BODY} ")
        matchstatuscodes=$([ -z "${MATCH_STATUS_CODES}" ] && echo "" || echo "--match-status-codes ${MATCH_STATUS_CODES} ")
        minservers=$([ -z "${MIN_SERVERS}" ] && echo "" || echo "--min-servers ${MIN_SERVERS} ")
        port=$([ -z "${PORT}" ] && echo "" || echo "--port ${PORT} ")
        threshold=$([ -z "${THRESHOLD}" ] && echo "" || echo "--threshold ${THRESHOLD} ")
        timeout=$([ -z "${TIMEOUT}" ] && echo "" || echo "--timeout ${TIMEOUT} ")

        execute_with_backoff az network application-gateway probe create -g ${RG_NAME} \
            --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME} --protocol ${PROTOCOL} \
            --path ${PROBEPATH} ${host}${hostnamefromhttpsettings}${interval}${matchbody}${matchstatuscodes}${minservers}${port}${threshold}${timeout}
        ;;
esac