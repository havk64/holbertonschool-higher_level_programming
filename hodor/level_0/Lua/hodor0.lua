#!/usr/bin/lua
-- ===-----------------------------------------------------------------------===
--      Hodor Projecto level 0, by Julien Barbier
--      Using Lua programming language.
--
--      By Alexandro de Oliveira.
-- ===-----------------------------------------------------------------------===

local http = require "socket.http"
local ltn12 = require "ltn12"
--local util = require "util"
    local reqbody = "id=23&holdthedoor=submit"
    local respbody = {}
    local  body, code, headers, status = http.request {
        method = "POST",
        url = "http://173.246.108.142/level0.php",
        source = ltn12.source.string(reqbody),
        headers =
                {
                        ["Accept"] = "*/*",
                        ["Accept-Encoding"] = "gzip, deflate",
                        ["Accept-Language"] = "en-us",
                        ["Content-Type"] = "application/x-www-form-urlencoded",
                        ["content-length"] = string.len(reqbody)
                },
        sink = ltn12.sink.table(respbody)
    }
print (tostring(body))
print (tostring(status))
print (tostring(code))
--    LOGINFO('body:' .. tostring(body))
--    LOGINFO('code:' .. tostring(code))
--    LOGINFO('headers:' .. util.tableToString(headers))
--    LOGINFO('status:' .. tostring(status))
