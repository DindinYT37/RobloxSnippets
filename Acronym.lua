local pattern = "[%w%p]+"
local special = "%p+"

return function(input: string): string
	local _s: string = ""

	for v in string.gmatch(input,pattern) do
		_s ..= string.sub(v,1,1) .. (string.match(v,special) or "")
	end

	return _s
end