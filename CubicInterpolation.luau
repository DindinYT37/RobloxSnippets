local function CubicInterpolation(a: number, b: number, c: number, d: number, x: number): number
	local p1 = d-c-a+b
	local p2 = a-b-p1
	local p3 = c-a
	local p4 = b
	
	return p1*x^3 + p2*x^2 + p3*x + p4
	
	--return (d-c-a+b)*x^3 + (-d+c+2*a-2*b)*x^2 + (c-a)*x + b
end

return CubicInterpolation