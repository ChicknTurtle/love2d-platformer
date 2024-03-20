
-- ### TurtleUtils
-- Many useful utility functions that should be in vanilla lua.
-- 
-- *by ChicknTurtle* - *v1.0.0*
local turtleutils = {
    _VERSION = "1.0.0",
}

local function check(name, value)
    if not value then
        error("'"..name.."' is a required argument.", 3)
    end
end
local function checkType(name, value, type1)
    if type(value) ~= type1 then
        error("Expected '"..name.."' to be a "..type1..". Got type '"..type1(value).."' instead.", 3)
    end
end
local function checkTwoTypes(name, value, type1, type2)
    if type(value) ~= type1 and type(value) ~= type2 then
        error("Expected '"..name.."' to be a "..type1.." or "..type2..". Got type '"..type1(value).."' instead.", 3)
    end
end
local function checkWholeNumber(name, value)
    if value % 1 ~= 0 then
        error("Expected '"..name.."' to be a whole number. Got '"..value.."' instead.", 3)
    end
end
local function checkBetween(name, value, a, b)
    if turtleutils.clamp(value, a, b) ~= value then
        error("'"..name.."' must be between "..a.." and "..b..". Got '"..value.."' instead.", 3)
    end
end

-- **Logs a message to the console.**  
-- Use this instead of `print()`!  
-- `msg` the message to log  
-- &nbsp; &nbsp; *Type: string, Required*  
-- `lvl` the level of the message  
-- &nbsp; &nbsp; *Type: number, Optional, default=1*  
-- 
-- Levels:  
-- 0 = DEBUG  
-- 1 = INFO  
-- 2 = WARNING  
-- 3 = ERROR  
---@param msg string
---@param lvl? number
---@return nil
function turtleutils.log(msg, lvl)
    check('msg', msg)
    checkType('msg', msg, 'string')
    if lvl then
        checkType('lvl', lvl, 'number')
        checkWholeNumber('lvl', lvl)
    else
        lvl = 1
    end

    local color = ''
    local level = ''

    if lvl == 0 then
        color = "\27[36m"
        level = "DEBUG"
    elseif lvl == 1 then
        color = "\27[32m"
        level = "INFO"
    elseif lvl == 2 then
        color = "\27[33m"
        level = "WARNING"
    elseif lvl == 3 then
        color = "\27[31m"
        level = "ERROR"
    end
    print(color.."["..level.."] "..msg.."\27[0m")
end

-- **Rounds a number.**  
-- `num` the number to round  
-- &nbsp; &nbsp; *Type: number, Required*  
-- `dec` the number of decimal places to round to  
-- &nbsp; &nbsp; *Type: number, Optional, default=0*  
-- 
-- **Example Usage:**  
-- `round(3.5) -> 4`  
-- `round(82.586, 2) -> 82.59`  
-- `round(-29.5) -> -30`  
---@param num number
---@param dec? number
---@return number
function turtleutils.round(num, dec)
    check('num', num)
    checkType('num', num, 'number')
    if dec then
        checkType('dec', dec, 'number')
        checkWholeNumber('dec', dec)
    else
        dec = 0
    end

    local m = 10^dec
    if num > 0 then
        return math.floor(num * m + 0.5) / m
    else
        return math.ceil(num * m - 0.5) / m
    end
end

-- **Gets the reciprocal of a number.**  
-- `num` the number to get the reciprocal of  
-- &nbsp; &nbsp; *Type: number, Required*  
-- 
-- Returns nil if 'num' is 0.  
-- Returns 0 is 'num' is math.huge or -math.huge.
-- 
-- **Example Usage:**  
-- `inverse(2) -> 0.5`  
-- `inverse(-10) -> -0.1`  
-- `inverse(0) -> nil`  
---@param num number
---@return number|nil
function turtleutils.inverse(num)
    check('num', num)
    checkType('num', num, 'number')

    if num == 0 then
        return nil
    elseif num == math.huge or num == -math.huge then
        return 0
    else
        return 1 / num
    end
end

-- **Interpolates a number.**  
-- `a` the starting number  
-- &nbsp; &nbsp; *Type: number, Required*  
-- `b` the ending number  
-- &nbsp; &nbsp; *Type: number, Required*  
-- `amount` the amount to interpolate by  
-- &nbsp; &nbsp; *Type: number, Optional, default=0.5*  
-- 
-- Also called tweening.
-- 
-- **Example Usage:**  
-- `interpolate(0, 5) -> 2.5`  
-- `interpolate(10, 11) -> 10.5`  
-- `interpolate(0, 5, 0.8) -> 4`  
---@param a number
---@param b number
---@param amount? number
---@return number
function turtleutils.interpolate(a, b, amount)
    check('a', a)
    check('b', b)
    checkType('a', a, 'number')
    checkType('b', b, 'number')
    if amount then
        checkType('amount', amount, 'number')
        checkBetween('amount', amount, 0, 1)
    else
        amount = 0.5
    end
    return a + (b - a) * amount
  end

-- **Appends an element onto the end of a table.**  
-- `tab` the table to be appended to  
-- &nbsp; &nbsp; *Type: table, Required*  
-- `val` the value to append  
-- &nbsp; &nbsp; *Type: any, Optional, default=nil*  
-- 
-- **Example Usage:**  
-- `append({5,6,7}, 8) -> {5,6,7,8}`  
-- `append({1,2,{'a','b','c'}}, 3) -> {1,2,{'a','b','c'},3}`  
-- `append({"a","b","c"}) -> {"a","b","c",nil}`  
---@param tab table
---@param val? any
---@return table
function turtleutils.append(tab, val)
    check('tab', tab)
    checkType('tab', tab, 'table')

    tab[#tab+1] = val
    return tab
end

-- **Reverses a table or string.**  
-- `tab` the table or string to reverse  
-- &nbsp; &nbsp; *Type: table/string, Required*  
-- 
-- **Example Usage:**  
-- `reverse({1,2,3}) -> {3,2,1}`  
-- `reverse({1,{'a','b'},3}) -> {3,{'a','b'},1}`  
-- `reverse('turtle') -> 'eltrut'`  
---@param tab table|string
---@return table|string
function turtleutils.reverse(tab)
    check('tab', tab)
    checkTwoTypes('tab', tab, 'table', 'string')

    if type(tab) == "table" then
        local reversed = {}
        for i = #tab, 1, -1 do
            table.insert(reversed, tab[i])
        end
        return reversed
    else
        local reversed = ""
        for i = #tab, 1, -1 do
            reversed = reversed .. string.sub(tab, i, i)
        end
        return reversed
    end
end

-- **Checks if a table contains a certain value.**  
-- `tab` the table to check for  
-- &nbsp; &nbsp; *Type: table, Required*  
-- `val` the value to search for  
-- &nbsp; &nbsp; *Type: any, Optional, default=nil*  
-- 
-- **Example Usage:**  
-- `contains({5,6,7}, 4) -> false`  
-- `contains({5,6,7}, 5) -> true`  
-- `contains({5,6,7}) -> false`  
---@param tab table
---@param val? any
---@return boolean
function turtleutils.contains(tab, val)
    check('tab', 'table')
    checkType('tab', tab, 'table')

    for _, item in ipairs(tab) do
        if item == val then
            return true
        end
    end
    return false
end

-- **Clamps a number between two values.**  
-- `num` the number to clamp  
-- &nbsp; &nbsp; *Type: number, Required*  
-- `min` the minimum value  
-- &nbsp; &nbsp; *Type: number, Optional, default=-infinity*  
-- `max` the maximum value  
-- &nbsp; &nbsp; *Type: number, Optional, default=infinity*  
-- 
-- **Example Usage:**  
-- `clamp(5, 1, 10) -> 5`  
-- `clamp(-5.2, 6.5) -> 6.5`  
-- `clamp(100, nil, 50) -> 50`  
---@param num number
---@param min? number
---@param max? number
---@return number
function turtleutils.clamp(num, min, max)
    check('num', num)
    checkType('num', num, 'number')
    if min then
        if type(min) ~= "number" then
            error("Expected 'min' to be a number. Got type '"..type(min).."' instead.", 2)
        end
    end
    if max then
        if type(max) ~= "number" then
            error("Expected 'max' to be a number. Got type '"..type(max).."' instead.", 2)
        end
    end
    min = min or -math.huge
    max = max or math.huge

    -- clamp
    return math.min(math.max(num, min), max)
end

-- **Gets the distance between two points.**  
-- `x1` the x position of the first point  
-- &nbsp; &nbsp; *Type: number, Required*  
-- `y1` the y position of the first point  
-- &nbsp; &nbsp; *Type: number, Required*  
-- `x2` the x position of the second point  
-- &nbsp; &nbsp; *Type: number, Required*  
-- `y2` the y position of the second point  
-- &nbsp; &nbsp; *Type: number, Required*  
-- 
-- **Example Usage:**  
-- `distance() -> 0`  
-- `distance() -> 0`  
-- `distance() -> 0`  
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
function turtleutils.distance(x1, y1, x2, y2)
    -- check types
    if not x1 then
        error("'x1' is a required argument.", 2)
    end
    if not y1 then
        error("'y1' is a required argument.", 2)
    end
    if not x2 then
        error("'x2' is a required argument.", 2)
    end
    if not y2 then
        error("'y2' is a required argument.", 2)
    end
    if type(x1) ~= "number" then
        error("Expected 'x1' to be a number. Got type '"..type(x1).."' instead.", 2)
    end
    if type(y1) ~= "number" then
        error("Expected 'y1' to be a number. Got type '"..type(y1).."' instead.", 2)
    end
    if type(x2) ~= "number" then
        error("Expected 'x2' to be a number. Got type '"..type(x2).."' instead.", 2)
    end
    if type(y2) ~= "number" then
        error("Expected 'y2' to be a number. Got type '"..type(y2).."' instead.", 2)
    end

    -- distance
    return ((x2 - x1)^2 + (y2 - y1)^2)^0.5
end

turtleutils.log("Using TurtleUtils version "..turtleutils._VERSION..".")

return turtleutils
