local function format(n: number): string
	if n < 1000 then return tostring(n) end

	local s,d = unpack(tostring(n):split("."))

	s = s:reverse():gsub("%d%d%d","%1,"):reverse()

	if d then
		s ..= "." .. d
	end

	if s:sub(1,1) == "," then
		s = s:sub(2)
	end

	return s
end

return format