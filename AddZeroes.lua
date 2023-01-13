-- Turn `n` into a number with `x` digits/characters

--[[
Examples (all with `x` being 4):
  12 -> 0012
 -12 -> -012
 1.2 -> 0001.2
-1.2 -> -001.2

Decimals are not capped by `x`:
 0.0001 = 0000.0001
-0.0001 = -001.0001
 8.6221 = 0008.6221
-8.6221 = -008.6221
--]]
local function AddZeroes(n: number, x: number): string
	local s,d = unpack(
		tostring(n):split(".")
	)
	
	s = string.format(`%0{x}d`, tonumber(s))
	
	s ..= d and ("." .. d) or ""
	
	if n < 0 then
		s = "-" .. s:sub(2)
	end
	
	return s
end

return AddZeroes