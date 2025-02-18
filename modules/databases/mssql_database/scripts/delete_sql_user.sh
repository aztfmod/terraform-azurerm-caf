#!/bin/bash

set -e

echo "[SQLSERVER]
Driver = ODBC Driver 17 for SQL Server
Server = tcp:${SQLCMDSERVER},1433
Authentication = SqlPassword" | sudo tee /etc/odbc.ini > /dev/null


sqlcmd -v DBUSERNAMES="${DBUSERNAMES}" \
       -S "${SQLCMDSERVER}" -d "master" -i "${SQLLOGINFILEPATH}" \
       -U "${DBADMINUSER}" -P "${DBADMINPWD}"
       
sqlcmd -v DBUSERNAMES="${DBUSERNAMES}" -S "${SQLCMDSERVER}" -d "${SQLCMDDBNAME}" -i "${SQLUSERFILEPATH}" -U "${DBADMINUSER}" -P "${DBADMINPWD}"