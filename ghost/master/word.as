function tenday
{
	return Random.Select([
		"tenday",
		"decad",
		"fortnight",
		"sennight",
		"triennium",
		"{Random.GetIndex(1, 16)} moons",
		"quarter year",
	]);
}