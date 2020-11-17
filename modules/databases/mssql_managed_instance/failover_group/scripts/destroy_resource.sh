#!/bin/bash

az resource delete --ids ${RESOURCE_IDS} --api-version 2017-10-01-preview || true

