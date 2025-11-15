/proc/generate_spirit_name(spirit_type) // TODO: make this better. there are 50+ spirits in WoD, and that's not condusive to this format.
	var/spirit_name
	var/spirit_table
	var/spirit_desc

	switch(spirit_type)
		if(SPIRIT_NIGHT)
			spirit_table = GLOB.night_spirits
		if(SPIRIT_DARKNESS)
			spirit_table = GLOB.darkness_spirits
		if(SPIRIT_VENGEANCE)
			spirit_table = GLOB.vengeance_spirits

	spirit_name = pick(spirit_table)
	spirit_desc = "[spirit_name], a spirit of [spirit_type]"

	return spirit_desc
