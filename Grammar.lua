local endings = [[!"�$%&/()=?{}[]\�`*+~'#.:,;]]

local function lastLetter(s: string): string
	if not s then return "" end
	return s:sub(#s,-1)
end
local function firstLetter(s: string): string
	if not s then return "" end
	return s:sub(1,1)
end
local function replaceFirst(s: string, w: string): string
	if not s then return "" end
	return w .. s:sub(2)
end

local function getOccurrences(s: string, func: ((string) -> (string))?): number
	local occurrences = 0
	for v in string.gmatch(s,".") do
		if v == (func or string.upper)(v) then
			occurrences += 1
		end
	end
	return occurrences / #s
end

local function isLower(s: string): boolean
	return string.lower(s) == s
end
local function isUpper(s: string): boolean
	return string.upper(s) == s
end

local function validEnding(e: string): boolean
	for d in string.gmatch(endings,".") do
		if d ~= e then continue end
		return true
	end
	return false
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