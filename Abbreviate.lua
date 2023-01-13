local abbreviations = {
	K = 4, M = 7, B = 10, T = 13, Qa = 16, Qi = 19, Sx = 22, Sp = 25, Oc = 28, No = 31,
	Dc = 34, UnDc = 37, DuoDc = 40, TreDc = 43, QtDc = 46, QiDc = 49, SxDc = 52, SpDc = 55, OcDc = 58, NvDc = 61,
	Vg = 64, UnVg = 67, DuoVg = 70, TreVg = 73, QtVg = 76, QiVg = 79, SxVg = 82, SpVg = 85, OcVg = 88, NvVg = 91,
	Trg = 94, UnTrg = 97, DuoTrg = 100, TreTrg = 103, QtTrg = 106, QiTrg = 109, SxTrg = 112, SpTrg = 115, OcTrg = 118, NvTrg = 121,
	Qdg = 124, UnQdg = 127, DuoQdg = 130, TreQdg = 133, QtQdg = 136, QiQdg = 139, SxQdg = 142, SpQdg = 145, OcQdg = 148, NvQdg = 151,
	Qig = 154, UnQig = 157, DuoQig = 160, TreQig = 163, QtQig = 166, QiQig = 169, SxQig = 172, SpQig = 175, OcQig = 178, NvQig = 181,
	Sxg = 184, UnSxg = 187, DuoSxg = 190, TreSxg = 193, QtSxg = 196, QiSxg = 199, SxSxg = 202, SpSxg = 205, OcSxg = 208, NvSxg = 211,
	Spg = 214, UnSpg = 217, DuoSpg = 220, TreSpg = 223, QtSpg = 226, QiSpg = 229, SxSpg = 231, SpSpg = 234, OcSpg = 237, NvSpg = 240,
	Ocg = 243, UnOcg = 246, DuoOcg = 249, TreOcg = 252, QtOcg = 255, QiOcg = 258, SxOcg = 261, SpOcg = 264, OcOcg = 267, NvOcg = 270,
	Nvg = 273, UnNvg = 276, DuoNvg = 279, TreNvg = 282, QtNvg = 285, QiNvg = 288, SxNvg = 291, SpNvg = 294, OcNvg = 297,
	Ct = 300, UnCt = 303, DuoCt = 306,
}

local function Abbreviate(number: number, decimals: number?, forceDecimals: boolean?): string
	local decimals = decimals or 2
	local forceDecimals = forceDecimals or false
	
	if number < 1000 then
		if forceDecimals then
			return string.format(`%.{decimals}f`,number), ""
		else
			return math.floor(number * 10^decimals) / 10^decimals, ""
		end
	end
	
	local floored = math.floor(number)
	local s = string.format("%d", floored)
	
	local chosen = next(abbreviations)
	for abbreviation, digits in pairs(abbreviations) do
		if math.floor(math.log10(floored) + 1) >= digits and math.floor(math.log10(floored) + 1) < (digits + 3) then
			chosen = abbreviation
			break
		end
	end
	
	if chosen then
		local digits = abbreviations[chosen]
		
		local rounded = math.floor(number / 10 ^ (digits - (decimals+1))) * 10 ^ (digits - (decimals+1))
		local n = rounded
		local m = digits
		s = string.format(`%.{decimals}f`, n / 10 ^ (m-1))
		
		if decimals > 0 and decimals < 5 and not forceDecimals then
			local last = s:sub(-1)
			
			while last == "0" do
				s = s:sub(1,-2)
				last = s:sub(-1)
			end
			
			if last == "." then
				s = s:sub(1,-2)
			end
		end
		
		s = s .. chosen
	else
		s = number
	end
	
	return s, (chosen or "")
end

return Abbreviate