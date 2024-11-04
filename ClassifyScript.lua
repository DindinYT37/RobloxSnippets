return function(s: Script|LocalScript|ModuleScript): string?
	if not (s:IsA("LocalScript") or s:IsA("ModuleScript") or s:IsA("Script")) then
		return nil
	end

	if s:IsA("LocalScript") then return "LocalScript" end
	if s:IsA("ModuleScript") then return "ModuleScript" end

	if s:IsA("Script") then
		return (s.RunContext and tostring(s.RunContext) or "Unknown")
	end

	return "Unknown"
end