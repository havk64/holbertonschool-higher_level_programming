require 'HTTPClient'

extheaders = {
  'User-Agent' => 'Holberton_School',
  'Authorization' => 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
}

search = 'https://api.github.com/search/repositories?q=language:ruby&sort=stars&order=desc'

http = HTTPClient.new
puts http.get_content(search, extheaders)
