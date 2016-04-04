#!/usr/bin/env python
from urllib2 import Request, urlopen, HTTPError, URLError

request_headers = {
        'User-Agent': 'Holberton_School',
        'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
    }
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars&order=desc'
request = Request(url, headers=request_headers) # Adding headers to the request

# Catching exceptions
try:
    print urlopen(request).read()
except HTTPError as error:
    print "Something went wrong!"
    print error
except URLError as error:
    print "Something went wrong!"
    print error
