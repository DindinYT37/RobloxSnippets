local function AngleBetween(v1: Vector3, v2: Vector3): number
	return math.atan2(v1:Cross(v2).Magnitude, v1:Dot(v2))
end

return AngleBetween