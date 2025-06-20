#!/bin/bash

# Define variables
ROOT_PATH="/opt/sms_gateway"

# Go into ROOT_PATH
cd $ROOT_PATH

# Create config files
cat > $GAMMU_SMSD_CONF <<EOL
# Configuration file for Gammu SMS Daemon

# Gammu library configuration, see gammurc(5)
[gammu]
device = ${GAMMU_DEVICE}
connection = ${GAMMU_DEVICE_CONNECTION}
baudrate = 19200
PIN = ""

# SMSD configuration, see gammu-smsdrc(5)
[smsd]
PIN = ${GAMMU_PIN}
Service = sql
Driver = native_mysql
Host = ${MYSQL_HOST}
User = ${MYSQL_USER}
Password = ${MYSQL_PASSWORD}
Database = ${MYSQL_DATABASE}
PhoneID = ${PHONE_ID}
HangupCalls = 1
DebugLevel = 3
MaxRetries = 3
RetryTimeout = 60
CommTimeout = 20
StatusFrequency = 600
ResetFrequency = 3600
CheckSecurity = 0
CheckBattery = 0
CheckSignal = 0
CheckNetwork = 1
Receive = 1
Send = 1
DeliveryReport = no

logfile = /dev/stdout
debuglevel = ${GAMMU_DEBUG_LEVEL}

EOL

# Delay start gammu-smsd
sleep 5s && /usr/bin/gammu-smsd --pid=/var/run/gammu-smsd.pid --config $GAMMU_SMSD_CONF --daemon &

# Start backend
python3 ./main.py
