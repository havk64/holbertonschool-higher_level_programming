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

#Function used to get the location of each user and concatenate with its full name.
def get_location(user):
    url_user = user['owner']['url']
    req = urllib2.Request(url_user, headers=request_headers)
    user_content = urllib2.urlopen(req).read()
    content = json.loads(user_content)
    user_obj =  {'full_name': user['full_name'],'location':content['location']}
    return user_obj
python_masters = []
for user in json_data['items']:
    python_masters.append(get_location(user))
print json.dumps(python_masters, sort_keys=True) # Using sort_keys to keep expected order.
