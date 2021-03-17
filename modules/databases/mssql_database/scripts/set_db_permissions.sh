#!/bin/bash

# update rover with odbcinst.ini > sql odbc driver to 17.7.2 / 17.6

echo "[SQLSERVER]
Driver = ODBC Driver 17 for SQL Server
Server = tcp:${SQLCMDSERVER},1433
Authentication = ActiveDirectoryMsi" | sudo tee -a /etc/odbc.ini > /dev/null

sqlcmd -v DBUSERNAMES="${DBUSERNAMES}" DBROLES="${DBROLES}" -S SQLSERVER -d "${SQLCMDDBNAME}" -i "${SQLFILEPATH}" -D