#!/bin/sh

set -e

echo "ASR backup configuration management"

case "${METHOD}" in
    PATCH)
        echo " - uri: ${URI}"
        echo " - payload: ${PAYLOAD}"

        az rest --method ${METHOD} --uri ${URI} --header Content-Type=application/json --body "${PAYLOAD}"

        echo "ASR Backup configuration updated."
        ;;
esac