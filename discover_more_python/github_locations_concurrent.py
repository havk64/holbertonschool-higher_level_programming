from urlparse import urlparse, urlunparse
from urllib import urlencode
from sys import exit
import urllib2
import json
import Queue
import threading


request_headers = {
        'User-Agent': 'Holberton_School',
        'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
    }
url = 'https://api.github.com'  # Base URL
path = '/search/repositories'   # Path for the first call
query = {                       # Query for first call
    'q': 'language:python',
    'sort':'stars',
    'order':'desc'
}

"""The function http_req is used for all http requests and it handles the errors gracefully"""
def http_req(path, query):
    purl = list(urlparse(url))
    purl[2] = path
    if query:
        purl[4] = urlencode(query)
    purl = urlunparse(purl)
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

#Function used to get the location of each user and concatenate with its full name.
def get_location(user):
    name = user['owner']['login']
    content = http_req('/users/'+name,{})
    user_obj = {'full_name': user['full_name'],'location':content['location']}
    return user_obj

# Main function to start all the data gathering
def get_data(user,python_masters, queue):
    result = get_location(user)
    python_masters.append(result)
    queue.put( result )

#First http call
json_data = http_req(path,query)

# Function that uses threading to do async http requests at the same time.
def async():
    result = Queue.Queue()
    python_masters = []     # Array that will store the data of each user.
    threads = [threading.Thread(target=get_data, args = (user, python_masters, result)) for user in json_data['items']  ]
    for t in threads:
        t.start()
    for t in threads:
        t.join()
    print json.dumps(python_masters, sort_keys=True)

# Start it!!!   
async()

