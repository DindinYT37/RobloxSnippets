return function(n: number, grid: number?): number
	local grid = grid or 1
	grid = math.clamp(grid,1,math.huge)
	return math.round(n/grid)*grid
end