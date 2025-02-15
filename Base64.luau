local Alphabet = {
	65, 66, 67, 68, 69, 70,
	71, 72, 73, 74, 75, 76,
	77, 78, 79, 80, 81, 82,
	83, 84, 85, 86, 87, 88, 89, 90,
	97, 98, 99, 100, 101, 102,
	103, 104, 105, 106, 107,
	108, 109, 110, 111, 112,
	113, 114, 115, 116, 117,
	118, 119, 120, 121, 122,
	48, 49, 50, 51, 52, 53,
	54, 55, 56, 57, 43, 47
}

local Indexes = {
	[43] = 63, [47] = 64, [48] = 53, [49] = 54, [50] = 55, [51] = 56,
	[52] = 57, [53] = 58, [54] = 59, [55] = 60, [56] = 61, [57] = 62,
	[65] = 1, [66] = 2, [67] = 3, [68] = 4, [69] = 5, [70] = 6, [71] = 7,
	[72] = 8, [73] = 9, [74] = 10, [75] = 11, [76] = 12, [77] = 13,
	[78] = 14, [79] = 15, [80] = 16, [81] = 17, [82] = 18, [83] = 19,
	[84] = 20, [85] = 21, [86] = 22, [87] = 23, [88] = 24, [89] = 25,
	[90] = 26, [97] = 27, [98] = 28, [99] = 29, [100] = 30, [101] = 31,
	[102] = 32, [103] = 33, [104] = 34, [105] = 35, [106] = 36, [107] = 37,
	[108] = 38, [109] = 39, [110] = 40, [111] = 41, [112] = 42, [113] = 43,
	[114] = 44, [115] = 45, [116] = 46, [117] = 47, [118] = 48, [119] = 49,
	[120] = 50, [121] = 51, [122] = 52,
}

local function Encode(input: string): string
	local output = {}
	local length = 0

	for index = 1, #input, 3 do
		local byte1, byte2, byte3 = string.byte(input, index, index + 2)

		-- Compute Base64 values
		local base64_1 = bit32.rshift(byte1, 2)
		local base64_2 = bit32.lshift(bit32.band(byte1, 3), 4) + bit32.rshift(byte2 or 0, 4)
		local base64_3 = bit32.lshift(bit32.band(byte2 or 0, 15), 2) + bit32.rshift(byte3 or 0, 6)
		local base64_4 = bit32.band(byte3 or 0, 63)

		length += 1
		output[length] = Alphabet[base64_1 + 1]

		length += 1
		output[length] = Alphabet[base64_2 + 1]

		length += 1
		output[length] = byte2 and Alphabet[base64_3 + 1] or 61  -- 61 is the ASCII code for '='

		length += 1
		output[length] = byte3 and Alphabet[base64_4 + 1] or 61
	end

	-- Combine output into chunks of size 4096 to prevent memory issues
	local encodedOutput = {}
	local encodedLength = 0

	for index = 1, length, 4096 do
		encodedLength = encodedLength + 1
		encodedOutput[encodedLength] = string.char(table.unpack(
			output,
			index,
			math.min(index + 4096 - 1, length)
		))
	end

	return table.concat(encodedOutput)
end

local function Decode(input: string): string
	local output = {}
	local length = 0

	-- Process input in chunks of 4 characters
	for index = 1, #input, 4 do
		local char1, char2, char3, char4 = string.byte(input, index, index + 3)

		-- Map characters to original values
		local index1 = Indexes[char1] - 1
		local index2 = Indexes[char2] - 1
		local index3 = (Indexes[char3] or 1) - 1
		local index4 = (Indexes[char4] or 1) - 1

		local byte1 = bit32.lshift(index1, 2) + bit32.rshift(index2, 4)
		local byte2 = bit32.lshift(bit32.band(index2, 15), 4) + bit32.rshift(index3, 2)
		local byte3 = bit32.lshift(bit32.band(index3, 3), 6) + index4

		length += 1
		output[length] = byte1

		if char3 ~= 61 then -- 61 is the ASCII code for '='
			length += 1
			output[length] = byte2
		end

		if char4 ~= 61 then
			length += 1
			output[length] = byte3
		end
	end

	-- Combine output into chunks of size 4096 to prevent memory issues
	local decodedOutput = {}
	local decodedLength = 0

	for index = 1, length, 4096 do
		decodedLength = decodedLength + 1
		decodedOutput[decodedLength] = string.char(table.unpack(
			output,
			index,
			math.min(index + 4096 - 1, length)
		))
	end

	return table.concat(decodedOutput)
end

return Encode, Decode