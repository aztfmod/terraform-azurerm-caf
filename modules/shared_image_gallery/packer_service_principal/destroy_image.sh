#!/bin/bash

az resource delete --ids ${RESOURCE_IDS} || true