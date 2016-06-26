--[[
===-----------------------------------------------------------------------===
     Defining a couple of helper functions in order to make the code
     more cleaner readable.

     By Alexandro de Oliveira.
===-----------------------------------------------------------------------===
--]]

-- Function to print a table:
function p (s)
    for k, v in pairs(s) do
        print (k ,"=>", v)
    end
end

-- Print a "deep" table(nested):
function deep_print(tbl)
    for i, v in pairs(tbl) do
        if type(v) == "table" then
            deep_print(v)
        else
            print(i, v)
        end
    end
end

-- Function table to String
function otherToString( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end
