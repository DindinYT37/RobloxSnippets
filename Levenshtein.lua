local function Levenshtein(compare: string, source: string): number
	local len1 = #compare
	local len2 = #source
	local column = {}

	if len1 == 0 then
		return len2
	elseif len2 == 0 then
		return len1
	elseif compare == source then
		return 0
	end

	for i = 1, len2+1 do
		column[i] = i
	end

	for i = 1,len1 do
		column[1] = i
		local lastdiag = i
		for j = 1,len2 do
			local olddiag = column[j]
			local cost = (compare:byte(i) == source:byte(j)) and 0 or 1
			column[j] = math.min(
				column[j] + 1,
				column[j + 1] + 1,
				lastdiag + cost
			)
			lastdiag = olddiag
		end
	end

	return column[len2 + 1]
end

return Levenshtein