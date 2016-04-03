import urllib2
import json
import sys

"""This function will convert any decoded JSON object from using unicode strings \
to UTF-8-encoded byte strings"""
def json_loads_byteified(json_text):
    return _byteify(
        json.loads(json_text, object_hook=_byteify),
        ignore_dicts=True
    )

def _byteify(data, ignore_dicts = False):
    # if this is a unicode string, return its string representation
    if isinstance(data, unicode):
        return data.encode('utf-8')
    # if this is a list of values, return list of byteified values
    if isinstance(data, list):
        return [ _byteify(item, ignore_dicts=True) for item in data ]
    # if this is a dictionary, return dictionary of byteified keys and values
    # but only if we haven't already byteified it
    if isinstance(data, dict) and not ignore_dicts:
        return {
            _byteify(key, ignore_dicts=True): _byteify(value, ignore_dicts=True)
            for key, value in data.iteritems()
        }
    # if it's anything else, return it in its original form
    return data

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
    user_obj = {'full_name': user['full_name'],'location':content['location']}
    return json.dumps(user_obj)
python_masters = []
for user in json_data['items']:
    python_masters.append(json_loads_byteified(get_location(user)))
print python_masters

