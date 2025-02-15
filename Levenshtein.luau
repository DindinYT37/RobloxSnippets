local function Levenshtein(compare: string, source: string): number
	local len1 = #compare
	local len2 = #source

	if len1 == 0 then
		return len2
	elseif len2 == 0 then
		return len1
	elseif compare == source then
		return 0
	end

	local column = {}
	for i = 1, len2+1 do
		column[i] = i
	end

	for i = 1,len1 do
		local lastdiag = column[1]
		column[1] = i
		for j = 1,len2 do
			local cost = (compare:byte(i) == source:byte(j)) and 0 or 1
			local olddiag = column[j + 1]
			column[j + 1] = math.min(
				column[j + 1] + 1,
				column[j] + 1,
				lastdiag + cost
			)
			lastdiag = olddiag
		end
	end

	return column[len2 + 1]
end

return Levenshtein