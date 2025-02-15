local function Reflection(origin: Vector3, hitpos: Vector3, normal: Vector3): Vector3
	local diff = hitpos - origin
	return diff - 2*(diff:Dot(normal) * normal)
end

return Reflection