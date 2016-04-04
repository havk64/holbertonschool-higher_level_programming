from urllib2 import Request, urlopen, HTTPError, URLError
from sys import exit

request_headers = {
        'User-Agent': 'Holberton_School',
        'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
    }
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars&order=desc'
request = Request(url, headers=request_headers) # Makes the request to the Github API

# Catching exceptions
try:
    contents = urlopen(request).read()   
except HTTPError as error:
    print "Something went wrong!"
    print error
    exit(0)
except URLError as error:
    print "Something went wrong!"
    print error
    exit(0)

""" This functions accepts two arguments, the file and the content to be written to the file
and returns a friendly message in case of succes or fail!"""
def write_to_file(file,content):
    try:
        file = open(file,'w')
        file.write( content )
        file.close()
        print 'The file was saved!'
        
    except Exception as e: # The exception object is asigned to the variable 'e'
        print 'Something went wrong!'
        print 'The file was NOT saved!'
        print 'See the reason below:'
        print e  # Prints the error message to the console in case of error
        exit(0)



write_to_file('/tmp/23', contents)    
