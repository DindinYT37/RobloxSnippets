-- Rounds `x` to the nearest multiple of `n`
local function Nearest(x: number, n: number): number
	return math.round(x/n) * n
end

return Nearest