#!/usr/bin/env ruby

require 'uri'
require 'net/http'

uri = URI.parse("http://173.246.108.142/level0.php")

http = Net::HTTP.new(uri.host, uri.port)

headers = {
    'User-Agent' => 'havk64 - Ruby Requests',
    'Content-Type' => 'application/x-www-form-urlencoded'
}
params = URI.encode_www_form({
    'id' => "2",
    'holdthedoor' => "submit"
})

resp, data = http.post(uri.path, params, headers)
puts resp.to_hash
