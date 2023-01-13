local ColorHSL = {}

function ColorHSL.toHSL(color: Color3): {H: number, S: number, L: number}
	local r,g,b = color.R, color.G, color.B
	local max, min = math.max(r,g,b), math.min(r,g,b)
	local h,s,l
	
	l = (max + min) / 2
	if max == min then
		h,s = 0,0
	else
		local d = max - min
		
		if l > 0.5 then
			s = d / (2-max-min)
		else
			s = d / (max+min)
		end
		
		if max == r then
			h = (g-b) / d
			if g < b then
				h += 6
			end
		elseif max == g then
			h = (b-r) / d+2
		elseif max == b then
			h = (r-g) / d+4
		end
		
		h /= 6
	end
	
	return {H = h, S = s, L = l}
end

function ColorHSL.fromHSL(h: number, s: number, l: number): Color3
	if h > 1 then h /= 360 end
	
	local r,g,b
	
	if s == 0 then
		r,g,b = l,l,l
	else
		local h2rgb = function(p,q,t)
			if t < 0 then t += 1 end
			if t > 1 then t -= 1 end

			if t < 1/6 then return p + (q-p) * 6 * t end
			if t < 0.5 then return q end
			if t < 2/3 then return p + (q-p) * (2/3 - t) * 6 end

			return p
		end

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