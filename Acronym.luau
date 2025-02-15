local pattern = "[%w%p]+"
local special = "%p+"

return function(input: string): string
	local acronym: string = ""

	for v in string.gmatch(input, pattern) do
		acronym ..= string.sub(v,1,1) .. (string.match(v,special) or "")
	end

	return acronym
end