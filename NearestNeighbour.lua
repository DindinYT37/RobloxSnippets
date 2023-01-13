-- Rounds `x` to the nearest neighbour of `n`
local function Nearest(x: number, n: number): number
	return math.round(x/n) * n
end

return Nearest