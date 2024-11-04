local _Random = Random.new()

local function Percentage(decimal: number): boolean
	return (_Random:NextNumber() < (tonumber(decimal) or 0))
end

local function OneInX(x: number): boolean
	return (_Random:NextNumber() < (tonumber(1/x) or 0))
end

local function Random(min: number, max: number): number
	return min + _Random:NextNumber()*(max-min)
end

return Percentage, OneInX