local function CosineInterpolation(a: number, b: number, x: number): number
	local x = (1 - math.cos(x*math.pi)) / 2
	return (a * (1-x) + b*x)
end

return CosineInterpolation