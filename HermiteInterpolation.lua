--[[
Tension:
	 1 = high
	 0 = normal
	-1 = low

Bias:
	0 is even
	positive is towards first segment
	negative is towards other segment
--]]

local function HermiteInterpolation(a: number, b: number, c: number, d: number, x: number, tension: number, bias: number): number
	local x1 = (b-a) * (1+bias) * (1-tension) / 2
	x1 += (c-b) * (1-bias) * (1-tension) / 2
	
	local x2 = (c-b) * (1+bias) * (1-tension) / 2
	x2 += (d-c) * (1-bias) * (1-tension) / 2
	
	local p1 =  2*x^3 - 3*x^2 + 1
	local p2 =    x^3 - 2*x^3 + x
	local p3 =    x^3 -   x^2
	local p4 = -2*x^3 + 3*x^2
	
	return (p1*b + p2*x1 + p3*x2 + p4*c)
end

return HermiteInterpolation