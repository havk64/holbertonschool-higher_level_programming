from urllib2 import Request, urlopen
from json import loads
from sys import exit

request_headers = {
        'User-Agent': 'Holberton_School',
        'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
    }
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars&order=desc'

request = Request(url, headers=request_headers)
contents = urlopen(request).read()
json_data = loads(contents)

"""Handling the errors. In case of some failure a friendly and clean message is displayed."""
try:
    for name in json_data['items']:
        print name['full_name']
except Exception as error:
    print "Something went wrong!"
    print error
    exit(0)