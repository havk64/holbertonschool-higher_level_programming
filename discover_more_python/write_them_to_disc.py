import urllib2

request_headers = {
        'User-Agent': 'Holberton_School',
        'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
    }
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars&order=desc'

request = urllib2.Request(url, headers=request_headers)
contents = urllib2.urlopen(request).read()

try:
    file = open('/tmp/23','w')
    file.write( contents )
    file.close()
    print 'The file was saved!'
except Exception as e:
    print 'Something went wrong!'
    print e
    sys.exit(0)


