local function PowColor3(color: Color3, power: number): Color3
	return Color3.new(
		color.R^power,
		color.G^power,
		color.B^power
	)
end

local function LerpColor(c1: Color3, c2: Color3, frac: number, gamma: number): Color3
	gamma = gamma or 2
	local c1 = PowColor3(c1, gamma)
	local c2 = PowColor3(c2, gamma)
	
	return PowColor3(c1:Lerp(c2, frac), 1/gamma)
end

return LerpColor