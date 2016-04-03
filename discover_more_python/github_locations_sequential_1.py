from urllib import urlencode
from sys import exit
import urllib2
import urlparse
import json


request_headers = {
        'User-Agent': 'Holberton_School',
        'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
    }
url = 'https://api.github.com'
path = '/search/repositories'
query = {
    'q': 'language:python',
    'sort':'stars',
    'order':'desc'
}

def http_req(path, query):
    purl = list(urlparse.urlparse(url))
    purl[2] = path
    purl[4] = urlencode(query)
    print purl
    purl = urlparse.urlunparse(purl)
    request = urllib2.Request(purl,headers=request_headers)

    try:
        contents = urllib2.urlopen(request).read()
        return json.loads(contents)
    except urllib2.HTTPError as error:
        print "Something went wront"
        print "The main reason is: ", str(error.reason)
        print error
        exit(0)
    except urllib2.URLError as error:
        print "Something went wrong!"
        print "The main reason is: ", str(error.reason)
        print error
        exit(0)
        
json_data = http_req(path,query)

#Function used to get the location of each user and concatenate with its full name.
def get_location(user):
    url_user = user['owner']['url']
    req = urllib2.Request(url_user, headers=request_headers)
    user_content = urllib2.urlopen(req).read()
    content = json.loads(user_content)
    user_obj = {'full_name': user['full_name'],'location':content['location']}
    return user_obj
python_masters = []
for user in json_data['items']:
    python_masters.append(get_location(user))
print json.dumps(python_masters)