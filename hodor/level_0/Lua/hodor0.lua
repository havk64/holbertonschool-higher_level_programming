#!/usr/bin/lua
--[[
 ===-----------------------------------------------------------------------===
      Hodor Project level 0, by Julien Barbier
      Using Lua programming language.

      By Alexandro de Oliveira.
 ===-----------------------------------------------------------------------===
--]]

--  To install the http package do: $ luarocks install luasocket
local http = require "socket.http"
local ltn12 = require "ltn12"
local io = require "io" -- To print the response body.
require "utils"

-- Defining some variables:
local url = "http://173.246.108.142/level0.php"
local reqbody = "id=23&holdthedoor=submit"

local count = 0
io.write("How many votes? => ") -- Prints the message requesting total votes.
local total = io.read("*n")     -- Reading a number from user.
-- Using the "repeat" statement to loop up to the the condition is met.
repeat
    local html = {} -- object to collect the response body.
    -- the POST Request:
    local _, _, headers = http.request {
        method = "POST",
        url = url,
        source = ltn12.source.string(reqbody),
        headers =
                {
                        ["Accept"] = "*/*",
                        -- Use this option if you don't to print the html body:
                        --["Accept-Encoding"] = "gzip, deflate",
                        ["Accept-Language"] = "en-us",
                        ["Content-Type"] = "application/x-www-form-urlencoded",
                        ["content-length"] = string.len(reqbody)
                    },
                    -- Reading the response body:
                     sink = ltn12.sink.table(html)
                }
        -- To print the response body(html):
        -- print(tostring(html[1]))
        -- To print the headers:
        -- print (p(headers))
        print ("Vote number: "..(count + 1))
        count = count + 1

until count == total

print ("You voted "..count.." times.\n")
