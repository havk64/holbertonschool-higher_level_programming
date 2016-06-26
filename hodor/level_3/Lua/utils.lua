
--[[ (<<< Multiline comments in Lua)
 ===-----------------------------------------------------------------------===
      Defining a couple of helper functions in order to make the code
      cleaner and more readable.

      By Alexandro de Oliveira.
 ===-----------------------------------------------------------------------===
--]]

-- Function to print a table:
function p (s)
    for k, v in pairs(s) do
        print (k ,"=>", v)
    end
end

-- Function split returns a Table(array like) of strings.
-- Lua doesn't have a builtin "split" method, but it has regexp. Using it here:
function split(str, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i = 1
        for str in string.gmatch(str, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

-- Function to parse a cookie from the http header(that uses the split function):
function parse(str)
    local cookie = split(str, ";")[1]
    local value = split(cookie, "=")[2]
    return {
        cookie = cookie,
        value = value
    }
end

function trim(s)
 local from = s:match"^%s*()"
 return from > #s and "" or s:match(".*%S", from)
end
