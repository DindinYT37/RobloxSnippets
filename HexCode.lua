return function(n: number): string
	return string.format(`%.{n}x`,math.floor(Random.new():NextNumber()*(16^n-1)))
end