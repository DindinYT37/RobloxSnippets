local function Map(n: number, oldMin: number, oldMax: number, min: number, max: number): number
	--[[
	Traditional:
		(min + ((max - min) * ((n - oldMin) / (oldMax - oldMin))))
	--]]
	
	-- Mine:
	return ((n-oldMin) / (oldMax-oldMin) * (max-min)+min)
end

return Map