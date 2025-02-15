local ColorHSL = {}

function ColorHSL.toHSL(color: Color3, degrees: boolean?): {H: number, S: number, L: number}
	local degrees = degrees or false
	
	local r,g,b = color.R, color.G, color.B
	local max, min = math.max(r,g,b), math.min(r,g,b)
	local h,s,l
	
	local sum = max + min
	local diff = max - min

	l = sum / 2
	if max == min then
		h,s = 0,0 -- Achromatic
	else
		if l > 0.5 then
			s = diff / (2-diff)
		else
			s = diff / sum
		end
		
		if max == r then
			h = (g-b) / diff
			if g < b then
				h += 6
			end
		elseif max == g then
			h = (b-r) / diff+2
		elseif max == b then
			h = (r-g) / diff+4
		end
		
		h /= 6
	end
	
	if degrees then h *= 360 end
	return {H = h, S = s, L = l}
end

local function h2rgb(p,q,t)
	if t < 0 then t += 1 end
	if t > 1 then t -= 1 end

	local qp = (q-p)

	if t < 1/6 then return p + qp*6 * t end
	if t < 0.5 then return q end
	if t < 2/3 then return p + qp*(2/3 - t) * 6 end

	return p
end

function ColorHSL.fromHSL(h: number, s: number, l: number, degrees: boolean?): Color3
	local degrees = degrees or h > 1
	if degrees then h /= 360 end
	
	local r,g,b
	
	if s == 0 then
		r,g,b = l,l,l -- Achromatic
	else
		local q = l < 0.5 and l * (1+s) or l+s - l*s
		local p = 2*l - q

		r = h2rgb(p,q,h + 1/3)
		g = h2rgb(p,q,h)
		b = h2rgb(p,q,h - 1/3)
	end
	
	return Color3.new(r,g,b)
end

function ColorHSL.LerpHSL(start: Color3, finish: Color3, alpha: number): Color3
	local c1 = ColorHSL.toHSL(start)
	local c2 = ColorHSL.toHSL(finish)
	
	local h1,s1,l1 = c1.H, c1.S, c1.L
	local h2,s2,l2 = c2.H, c2.S, c2.L
	
	if math.abs(h2-h1) > 0.5 then
		if h1 > h2 then
			h2 += 1
		else
			h2 -= 1
		end
	end
	
	local h = h1 + (h2 - h1) * alpha
	h = (h + 1) % 1
	local s = s1 + (s2 - s1) * alpha
	local l = l1 + (l2 - l1) * alpha
	
	return ColorHSL.fromHSL(h,s,l)
end

return ColorHSL