#!/bin/bash

az sql midb ltr-policy set -g ${RESOURCE_GROUP_NAME} --mi ${SERVER_NAME} -n ${DB_NAME} --weekly-retention "PT0S" --monthly-retention "PT0S" || true

