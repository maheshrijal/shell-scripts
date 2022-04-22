#!/bin/bash
# Script to unlock a oracle db with sqlplus

export ORACLE_HOME=/opt/oracle/product/10.2.0.1_64b
export ORACLE_BASE=/u01/app/oracle
export ORACLE_SID=mhs
export PATH=/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/oracle/product/10.2.0.1_64b/bin:/home/mhs/bin
export LD_LIBRARY_PATH=/opt/oracle/product/10.2.0.1_64b/lib

USER=user
PASSWORD=user123
HOST=192.168.114.51
PORT=1521
SID=mhs

SQL_FILE=/home/mhs/unlock_script.sql

sqlplus ${USER}/${PASSWORD}//${HOST}:${PORT}/${SID} << EOF > /home/mhs/log.out
@/home/mhs/exec.sql
exit
EOF
