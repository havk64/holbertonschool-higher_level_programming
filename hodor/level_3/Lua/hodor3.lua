#!/usr/bin/lua
--[=====[
 ===-----------------------------------------------------------------------===
      Hodor Project level 3, by Julien Barbier
      Using Lua programming language and Tesseract-OCR.

      By Alexandro de Oliveira.
 ===-----------------------------------------------------------------------===
--]=====]
function trim(s)
 local from = s:match"^%s*()"
 return from > #s and "" or s:match(".*%S", from)
end
--  To install the http package do: $ luarocks install luasocket
local http = require "socket.http"
local ltn12 = require "ltn12"
local lfs = require "lfs"
-- local io = require "io" --> Uncomment to use io.stdout to print the html body.
require "utils" -- Importing the external file utils.lua.

local url = "http://173.246.108.142/level3.php"
local captcha_url = "http://173.246.108.142/captcha.php"
local count = 0
io.write("How many votes? => ") -- Prints the message requesting total votes.
local total = io.read("*n")     -- Reading a number from user.

while count < total do
    -- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
    -- Fetch the captcha, decoding it, and parse PHP session cookie:
    local filePath = lfs.currentdir().."/tmp.png"
    local img = assert(io.open(filePath, "w"))
    local n, ok, header = http.request {
        url = captcha_url,
        sink = ltn12.sink.file(img)
    }
    img.close()
    local handle = io.popen("tesseract tmp.png - 2> /dev/null")
    local captcha = trim(handle:read("*a")); handle.close()
    --print (type(handle), '\"'..captcha..'\"', string.len(captcha))
    --print (line, p(header))

    local cookie_session = parse(header['set-cookie'])['cookie']
    -- Check the PHP session cookie value:
    -- print (cookie_session)

    -- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
    -- HEAD request to get a cookie and use it in the POST request.
    local body, code, headers, status = http.request {
        method = "HEAD",
        url = url,
        headers =
                {
                        ['User-Agent'] = "Windows NT 5.1 'Moonlight' Havk64 Lua Requests",
                        ['Cookie'] = cookie_session -- Using the PHP session cookie.
                }
    }
    local hc = headers['set-cookie']
    local tcookie = parse(hc)
    local cookie = tcookie['cookie']
    local value = tcookie['value']
    -- Print the Header of HEAD request:
    -- print (p(headers))

    -- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
    -- Preparing the POST request:
    local reqbody = "id=23&holdthedoor=submit&key="..value.."&captcha="..captcha
    local body, code, headers, status = http.request {
        method = "POST",
        url = url,
        source = ltn12.source.string(reqbody),
        headers =
                {
                        ["Accept"] = "*/*",
                        ["Accept-Encoding"] = "gzip, deflate",
                        ["Accept-Language"] = "en-us",
                        ["Referer"] = url,
                        ['User-Agent'] = "Windows NT 5.1 'Moonlight' Havk64 Lua Script Requests",
                        ["Cookie"] = cookie.."; "..cookie_session,
                        ["Content-Type"] = "application/x-www-form-urlencoded",
                        ["content-length"] = string.len(reqbody)
                    },
                -- Print the response body(html):
                -- sink = ltn12.sink.file(io.stdout)
        }
        -- Checking the response header:
        -- print (p(headers))
        local test = headers['set-cookie']
        if test ~= nil then -- Testing if the vote was valied(a new cookie was set):
            print("Vote number: "..(count + 1))
            count = count + 1
        else
            print("Failed")
        end
end
