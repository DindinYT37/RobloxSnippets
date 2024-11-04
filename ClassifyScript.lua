return function(s: Script|LocalScript|ModuleScript): string?
	if (
		(
			not s:IsA("LocalScript"))
			and (not s:IsA("ModuleScript"))
			and (not s:IsA("Script"))
		) then
		return nil
	end

	if s:IsA("LocalScript") then return "LocalScript" end
	if s:IsA("ModuleScript") then return "ModuleScript" end

	if not s:IsA("Script") then
		return "Unknown"
	end

	if s.RunContext == Enum.RunContext.Legacy then return "LegacyScript" end
	if s.RunContext == Enum.RunContext.Client then return "ClientScript" end
	if s.RunContext == Enum.RunContext.Plugin then return "PluginScript" end
	if s.RunContext == Enum.RunContext.Server then return "ServerScript" end

	return "Unknown"
end