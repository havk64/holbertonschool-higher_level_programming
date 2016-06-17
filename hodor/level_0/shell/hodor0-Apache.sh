#!/bin/bash

# ===---Hodor Level 0-------------------------------------------------------------===
#  Solution in Shell Script for Hodor Project Level 0, by Julien Barbier
#  Using Apache HTTP server benchmarking tool.
#  More info: http://httpd.apache.org/docs/2.4/programs/ab.html
#
#  by Alexandro de Oliveira, for Holberton School.
# ===-----------------------------------------------------------------------------===

URL=http://173.246.108.142/level0.php	# URL
TYPE=application/x-www-form-urlencoded	# Content Type.
REQ=$((1 << 10))			# Total number of requests.
FILE=params	 			# Name of the file with the encode string to be submitted.
CONC=50					# Number of concurrent requests.
VERB=1					# Verbosity level

ab -n $REQ -c $CONC -T $TYPE -p $FILE -v $VERB $URL
