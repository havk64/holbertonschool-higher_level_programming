#!/bin/bash

# ===-----------------------------------------------------------------------------===
# Solution in Shell Script for Hodor Project by Julien Barbier - Holberton School
# Using curl command taking advantage of its default 'keep-alive' connection.
# If you want to see more details about each request replace the "s" option with "v"
# right after the 'curl' command.	
# ===-----------------------------------------------------------------------------===

URL=http://173.246.108.142/level0.php
AGENT='havk64 - Curl requests'
ID='id=23'
COUNT=0
VOTES=$((1 << 4)) # Bitwise operation which results in 1024.



### Voting 1024 times:
while [ $COUNT -lt $VOTES ]
do
    curl -s -d "$ID&holdthedoor=submit" -A "$AGENT"  $URL -o /dev/null
    echo "Vote: "$COUNT
    ((COUNT++))
done


