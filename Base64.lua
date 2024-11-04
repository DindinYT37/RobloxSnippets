local Alphabet = {
	65, 66, 67, 68, 69, 70,
	71, 72, 73, 74, 75, 76,
	77, 78, 79, 80, 81, 82,
	83, 84,
	85, 86, 87, 88, 89, 90,
	97, 98, 99, 100, 101, 102,
	103, 104, 105, 106, 107,
	108, 109, 110, 111, 112,
	113, 114, 115, 116, 117,
	118, 119, 120, 121, 122,
	48, 49, 50, 51, 52, 53,
	54, 55, 56, 57, 43, 47
}
local Indexes = {
	[43] = 63,
	[47] = 64,
	[48] = 53,
	[49] = 54,
	[50] = 55,
	[51] = 56,
	[52] = 57,
	[53] = 58,
	[54] = 59,
	[55] = 60,
	[56] = 61,
	[57] = 62,
	[65] = 1,
	[66] = 2,
	[67] = 3,
	[68] = 4,
	[69] = 5,
	[70] = 6,
	[71] = 7,
	[72] = 8,
	[73] = 9,
	[74] = 10,
	[75] = 11,
	[76] = 12,
	[77] = 13,
	[78] = 14,
	[79] = 15,
	[80] = 16,
	[81] = 17,
	[82] = 18,
	[83] = 19,
	[84] = 20,
	[85] = 21,
	[86] = 22,
	[87] = 23,
	[88] = 24,
	[89] = 25,
	[90] = 26,
	[97] = 27,
	[98] = 28,
	[99] = 29,
	[100] = 30,
	[101] = 31,
	[102] = 32,
	[103] = 33,
	[104] = 34,
	[105] = 35,
	[106] = 36,
	[107] = 37,
	[108] = 38,
	[109] = 39,
	[110] = 40,
	[111] = 41,
	[112] = 42,
	[113] = 43,
	[114] = 44,
	[115] = 45,
	[116] = 46,
	[117] = 47,
	[118] = 48,
	[119] = 49,
	[120] = 50,
	[121] = 51,
	[122] = 52
}

local function Encode(Input: string): string
	local Output = {}
	local Length = 0

	for Index = 1, #Input, 3 do
		local C1, C2, C3 = string.byte(Input, Index, Index + 2)

		local A = bit32.rshift(C1, 2)
		local B = bit32.lshift(bit32.band(C1, 3), 4) + bit32.rshift(C2 or 0, 4)
		local C = bit32.lshift(bit32.band(C2 or 0, 15), 2) + bit32.rshift(C3 or 0, 6)
		local D = bit32.band(C3 or 0, 63)

		Length = Length + 1
		Output[Length] = Alphabet[A + 1]

		Length = Length + 1
		Output[Length] = Alphabet[B + 1]

		Length = Length + 1
		Output[Length] = C2 and Alphabet[C + 1] or 61

		Length = Length + 1
		Output[Length] = C3 and Alphabet[D + 1] or 61
	end

	local NewOutput = {}
	local NewLength = 0
	local IndexAdd4096Sub1

	for Index = 1, Length, 4096 do
		NewLength = NewLength + 1
		IndexAdd4096Sub1 = Index + 4096 - 1

		NewOutput[NewLength] = string.char(table.unpack(
			Output,
			Index,
			IndexAdd4096Sub1 > Length and Length or IndexAdd4096Sub1
			))
	end

	return table.concat(NewOutput)
end

local function Decode(Input: string): string
	local Output = {}
	local Length = 0

	for Index = 1, #Input, 4 do
		local C1, C2, C3, C4 = string.byte(Input, Index, Index + 3)

		local I1 = Indexes[C1] - 1
		local I2 = Indexes[C2] - 1
		local I3 = (Indexes[C3] or 1) - 1
		local I4 = (Indexes[C4] or 1) - 1

		local A = bit32.lshift(I1, 2) + bit32.rshift(I2, 4)
		local B = bit32.lshift(bit32.band(I2, 15), 4) + bit32.rshift(I3, 2)
		local C = bit32.lshift(bit32.band(I3, 3), 6) + I4

		Length = Length + 1
		Output[Length] = A

		if C3 ~= 61 then
			Length = Length + 1
			Output[Length] = B
		end

		if C4 ~= 61 then
			Length = Length + 1
			Output[Length] = C
		end
	end

	local NewOutput = {}
	local NewLength = 0
	local IndexAdd4096Sub1

	for Index = 1, Length, 4096 do
		NewLength = NewLength + 1
		IndexAdd4096Sub1 = Index + 4096 - 1

		NewOutput[NewLength] = string.char(table.unpack(
			Output,
			Index,
			IndexAdd4096Sub1 > Length and Length or IndexAdd4096Sub1
			))
	end

	return table.concat(NewOutput)
end

return Encode, Decode