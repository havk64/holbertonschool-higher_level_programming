import urllib2
import sys

request_headers = {
        'User-Agent': 'Holberton_School',
        'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
    }
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars&order=desc'

def write_to_file(file,content):
    try:
        file = open(file,'w')
        file.write( contents )
        file.close()
        print 'The file was saved!'
        
    except Exception as e:
        print 'Something went wrong!'
        print e
        sys.exit(0)

request = urllib2.Request(url, headers=request_headers)
contents = urllib2.urlopen(request).read()

file = '/tmp/23'
write_to_file(file, contents)    
