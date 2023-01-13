local function Lerp(a: number, b: number, x: number): number
	return (a * (1-x) + b*x)
end

return Lerp