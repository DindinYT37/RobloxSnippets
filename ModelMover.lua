-- Basically `SetPivot`
--[[
Example:
	local moveMyModel = ModelMover(workspace.Model)
	moveMyModel(CFrame.new(69,37,420))
--]]

local function ModelMover(m: Model): (new: CFrame) -> nil
	local primary = m.PrimaryPart
	local primaryCF = primary.CFrame
	local cache = {}
	
	for _,v in ipairs(m:GetDescendants()) do
		if (v:IsA("Basepart") and v ~= primary) then
			cache[v] = primaryCF:ToObjectSpace(v.CFrame)
		end
	end
	
	return function(newCF: CFrame)
		primary.CFrame = newCF
		for v,offset in pairs(cache) do
			v.CFrame = newCF * offset
		end
	end
end

return ModelMover