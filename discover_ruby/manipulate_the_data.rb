require 'HTTPClient'
require "rubygems"
require "json"

extheaders = {
  'User-Agent' => 'Holberton_School',
  'Authorization' => 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
}

search = 'https://api.github.com/search/repositories?q=language:ruby&sort=stars&order=desc'

http = HTTPClient.new
res = http.get_content(search, extheaders)
string = JSON.parse(res)
result = string["items"].map { |item| item["full_name"]}.join("\n")
#result.join("\n")
