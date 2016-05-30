#!/usr/bin/env ruby

require 'uri'
require 'net/http'

uri = URI.parse("http://173.246.108.142/level1.php")
cookie = "6b695713db9b371a855adf1e229264c681f2e48"
http = Net::HTTP.new(uri.host, uri.port)

headers = {
    'User-Agent' => 'havk64 - Ruby Requests',
    'Content-Type' => 'application/x-www-form-urlencoded',
    'Cookie' => 'HoldTheDoor=' << cookie
}
puts headers
params = URI.encode_www_form({
    'id' => "23",
    'holdthedoor' => "submit",
    'key' => cookie
})

resp, data = http.post(uri.path, params, headers)
puts resp.to_hash
