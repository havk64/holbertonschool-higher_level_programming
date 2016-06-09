#!/bin/bash

# ===---Hodor Level 3-------------------------------------------------------------===
# Solution in Shell Script for Hodor Project Level 3, by Julien Barbier
# Emulating a "session"(remembering that http is "stateless").
#
# by Alexandro de Oliveira, for Holberton School.
# ===-----------------------------------------------------------------------------===

URL=http://173.246.108.142/level3.php
ID='id=23'

COUNT=0
VOTES=$((1 << 10)) #  = 1024

### Voting 1024 times:
while [ $COUNT -lt $VOTES ]
do
: <<'END'
    # The "meat" code goes here! >:-D
END
    ((COUNT++))
done
