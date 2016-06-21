#!/usr/bin/env python

"""

===---Hodor Level 4----------------------------------------------------------===
   Solution for the Hodor Project, Level 4 by Julien Barbier.
   Using Python script and Tor network with Stem and requesocks.

   by Alexandro de Oliveira, for Holberton School
===--------------------------------------------------------------------------===

"""

from stem import Signal
from stem.control import Controller
import requesocks
from time import sleep

session = requesocks.session()
# Tor uses the 9050 port as the default socks port
session.proxies = {'http':  'socks5://127.0.0.1:9050',
                   'https': 'socks5://127.0.0.1:9050'}

# Getting password for Tor controller:
passwd = raw_input('Enter the Tor password => ')

# Make a request through the Tor connection(using your current Tor 'exit')
# IP visible through Tor:(To check your current IP in Tor network)
# print session.get("http://httpbin.org/ip").text
# Above should print an IP different than your public IP
# Following prints your normal public IP

# Signal TOR for a new connection
def renew_connection():
    with Controller.from_port(port = 9051) as controller:
        controller.authenticate(password=passwd)
        controller.signal(Signal.NEWNYM)

# As the amount of errors(recurring IPs) could be huge we needs to ensure that we get the
# right amount of votes we want. We are using a while and the counter just
# increments when we get a valid vote.
vote = 1
total_votes = 100
while vote < total_votes:
    # If you want to check your current IP:
    # print session.get("https://api.ipify.org").text
    # print session.get("http://httpbin.org/ip").text
    url = "http://173.246.108.142/level4.php"
    headers = { "Referer": url }
    # HEAD Request to get a valid cookie:
    head = session.head(url, headers = headers)
    # print head.headers
    cookie = head.cookies["HoldTheDoor"]
    # Add the cookie to the header:
    headers['Cookie'] = "HoldTheDoor=" + cookie
    body = {
        'id': '23',
        'holdthedoor': 'submit',
        'key': cookie,
    }
    post = session.post(url, data = body, headers = headers)
    post_cookie = post.headers['set-cookie']
    if post_cookie:
        print "Vote number: " + str(vote)
        vote += 1
        # For more info(debug):
        # print post.headers
        # print post.text
    else:
        print "Failed..."

    # Requeste new identity:
    renew_connection()
    # Wait a bit in order to make sure your new identity would be granted by the Tor network:
    sleep(10)
