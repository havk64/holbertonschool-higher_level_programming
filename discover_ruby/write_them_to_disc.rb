require 'HTTPClient'

extheaders = {
  'User-Agent' => 'Holberton_School',
  'Authorization' => 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
}

search = 'https://api.github.com/search/repositories?q=language:ruby&sort=stars&order=desc'

http = HTTPClient.new
res = http.get_content(search, extheaders)
begin
  file = File.open('/tmp/23', 'w')
  file.write(res)
rescue Exception => e
  print "Failed to create/write to the file:\n" + e.to_s
ensure
  (print "The file was saved!"; file.close;) unless file.nil?
end
