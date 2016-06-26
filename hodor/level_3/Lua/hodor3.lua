#!/usr/bin/lua
--[=====[
 ===-----------------------------------------------------------------------===
      Hodor Project level 2, by Julien Barbier
      Using Lua programming language.

      By Alexandro de Oliveira.
 ===-----------------------------------------------------------------------===
--]=====]

--  To install the http package do: $ luarocks install luasocket
local http = require "socket.http"
local ltn12 = require "ltn12"
local lfs = require "lfs"
require "utils" -- Importing the external file utils.lua.

local url = "http://173.246.108.142/captcha.php"
local count = 0
io.write("How many votes? => ") -- Prints the message requesting total votes.
--local total = io.read("*n")     -- Reading a number from user.

local filePath = lfs.currentdir().."/tmp.png"
print (filePath)
local img = assert(io.open(filePath, "w"))
local n, ok, header, line, e, f = http.request {
    url = url,
    sink = ltn12.sink.file(img)
}
img.close()
print ( line, type(e), e, f, type(f))

--[=====[
n = number (1)
ok = number (200)
header = table
line = http 1.1 200 (string)

while count < total do
    -- HEAD request to get a cookie and use it in the POST request.
    local body, code, headers, status = http.request {
        method = "HEAD",
        url = url,
        headers =
                {
                        ['User-Agent'] = "Windows NT 5.1 'Moonlight' Havk64 Lua Requests"
                }
    }
    local hc = headers['set-cookie']
    -- print (hc)
    local tcookie = parse(hc)
    local cookie = tcookie['cookie']
    local value = tcookie['value']
    -- Print the Header of HEAD request:
    -- print (p(headers))

    -- Preparing the POST request:
    local reqbody = "id=23&holdthedoor=submit&key="..value
    local respbody = {}
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
                        ["Cookie"] = cookie,
                        ["Content-Type"] = "application/x-www-form-urlencoded",
                        ["content-length"] = string.len(reqbody)
                    },

                    sink = ltn12.sink.table(respbody)

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
--]=====]
