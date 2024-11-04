local function format(n: number): string
	if n < 1000 then return tostring(n) end

	local s,d = unpack(
		tostring(n):split(".")
	)

	s = s:reverse()
	s = s:gsub("%d%d%d","%1,")
	s = s:reverse()

	s ..= d and ("." .. d) or ""

	return s:sub(1,1) == "," and s:sub(2) or s
end

return format