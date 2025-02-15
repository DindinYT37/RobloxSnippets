local endings = [[!"�$%&/()=?{}[]\�`*+~'#.:,;]]

local function lastLetter(s: string): string
	return s and s:sub(-1) or ""
end
local function firstLetter(s: string): string
	return s and s:sub(1,1) or ""
end
local function replaceFirst(s: string, w: string): string
	return s and (w .. s:sub(2)) or ""
end

local function getOccurrences(s: string, func: ((string) -> (string))?): number
	func = func or string.upper
	local occurrences = 0
	for v in s:gmatch(".") do
		if v == func(v) then
			occurrences += 1
		end
	end
	return #s > 0 and occurrences/#s or 0
end

local function isLower(s: string): boolean
	return string.lower(s) == s
end
local function isUpper(s: string): boolean
	return string.upper(s) == s
end

local function validEnding(e: string): boolean
	return endings:find(e,1,true) and true or false
end

local function Grammar(s: string): string
	if not s then return "" end
	s = replaceFirst(s, string.upper(firstLetter(s)))
	s = string.gsub(s," i "," I ")
	
	if not validEnding(lastLetter(s)) then
		if getOccurrences(s) > 0.8 then
			s ..= "!"
		else
			s ..= "."
		end
	end
	return s
end

return Grammar