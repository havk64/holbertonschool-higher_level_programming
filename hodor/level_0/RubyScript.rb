#!/usr/bin/env ruby

require 'uri'
require 'net/http'

=begin <= Ruby multiline comment
===---Description---------------------------------------------------------------===
# Solution for the Hodor Project, Level 0 by Julien Barbier.
# Using Ruby Language.
# by Alexandro de Oliveira, for Holberton School
===-----------------------------------------------------------------------------===
=end

# Parsing the URL:
uri = URI.parse("http://173.246.108.142/level0.php")
# Setting the http request:
http = Net::HTTP.new(uri.host, uri.port)
# Setting the http request headers:
headers = {
    'User-Agent' => 'havk64 - Ruby Requests',
    'Content-Type' => 'application/x-www-form-urlencoded'
}
# Setting POST request parameters:
params = URI.encode_www_form({
    'id' => "23",
    'holdthedoor' => "submit"
})
# Making the POST request:
resp, data = http.post(uri.path, params, headers)
# Optionally printing the response object hash:
puts resp.to_hash
