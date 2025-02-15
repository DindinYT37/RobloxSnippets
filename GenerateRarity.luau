local Rarities = {
	[1] = { -- Index
		Name = "COMMON", -- Name of Rarity
		Chance = 63 -- Chance in percent
	},
	[2] = {
		Name = "UNCOMMON",
		Chance = 30
	},
	[3] = {
		Name = "RARE",
		Chance = 5
	},
	[4] = {
		Name = "EPIC",
		Chance = 1.9
	},
	[5] = {
		Name = "LEGENDARY",
		Chance = 0.1
	}
}

-- Setup
Rarities[4].Chance += Rarities[5].Chance
Rarities[3].Chance += Rarities[4].Chance
Rarities[2].Chance += Rarities[3].Chance
Rarities[1].Chance += Rarities[2].Chance

local function isWithin(x: number, min: number, max: number): boolean
	return ((x > min) and (x <= max))
end

return function(): string
	local r = Random.new(math.random(100000000,999999999))
	local n = r.NextNumber(r) * 100
	
	for i = 1,#Rarities do
		if isWithin(
			n,
			(i == #Rarities and 0 or Rarities[i+1].Chance), -- 0 if last index, next rarity's chance if not
			Rarities[i].Chance
			) then
			return Rarities[i].Name
		end
	end
	
	return "ERROR"
end