#!/bin/bash

set -e

function hub_route_table {

    echo "Set hub_route_table:"
    echo " - properties:"
    echo "${PROPERTIES}" | jq -r
    echo " - url: ${URL}"

    az rest --method PUT --url ${URL} --header Content-Type=application/json --body "${PROPERTIES}"

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
