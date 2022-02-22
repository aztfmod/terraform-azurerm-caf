#!/bin/bash

set -e

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

function hub_route_table {

    echo "Set hub_route_table:"
    echo " - properties:"
    echo "${PROPERTIES}" | jq -r
    echo " - url: ${URL}"

    execute_with_backoff az rest --method PUT --url ${URL} --header Content-Type=application/json --body "${PROPERTIES}"

}


case "${METHOD}" in
    PUT)
        hub_route_table
        echo "Route table set."
        ;;
    DELETE)
        az rest --method DELETE --url ${URL}
        echo "Route table removed."
        ;;
esac
