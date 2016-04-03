import urllib2
import json
import sys

request_headers = {
        'User-Agent': 'Holberton_School',
        'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
    }
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars&order=desc'

request = urllib2.Request(url, headers=request_headers)
contents = urllib2.urlopen(request).read()
json_data = json.loads(contents)

"""Handling the errors. In case of some failure a friendly and clean message is displayed."""
try:
    for name in json_data['items']:
        print name['full_name']
except Exception as error:
    print "Something went wrong!"
    print error
    sys.exit(0)