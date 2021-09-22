#!/bin/bash

TIMESTAMP=`date +%s`
ping -c 1 -W 0.7 8.8.4.4 > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "status: UP at `date +%Y-%m-%dT%H:%M:%S%Z`";
    INTERNET_STATUS="UP"
else
    echo "status: DOWN at `date +%Y-%m-%dT%H:%M:%S%Z`";
    INTERNET_STATUS="DOWN"
fi
while [ 1 ]
 do
    ping -c 1 -W 0.7 8.8.4.4 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        if [ "$INTERNET_STATUS" != "UP" ]; then
            echo "down for $((`date +%s`-$TIMESTAMP)) seconds; now up; time: `date +%Y-%m-%dT%H:%M:%S%Z`";
            INTERNET_STATUS="UP"
            TIMESTAMP=`date +%s`
        fi
    else
        if [ "$INTERNET_STATUS" = "UP" ]; then
            echo "  up for $((`date +%s`-$TIMESTAMP)) seconds; now down; time: `date +%Y-%m-%dT%H:%M:%S%Z`";
            INTERNET_STATUS="DOWN"
            TIMESTAMP=`date +%s`
        fi
    fi
    sleep 1
 done;
