/proc/compose_dir(mob/living/carbon/human/target, mob/living/carbon/human/user, turf/targetturf, method = LOCATOR_NORMAL)
	var/ourturf = get_turf(user)

	if(method == "Masquerade" || method == "Veil")
		if(!(GLOB.masquerade_breakers_list.len))
			return FALSE

	var/direction = get_dir(ourturf, targetturf)
	var/dirtext

	switch(direction)
		if(NORTH)
			dirtext = "the north"
		if(SOUTH)
			dirtext = "the south"
		if(EAST)
			dirtext = "the east"
		if(WEST)
			dirtext = "the west"
		if(NORTHWEST)
			dirtext = "the northwest"
		if(NORTHEAST)
			dirtext = "the northeast"
		if(SOUTHWEST)
			dirtext = "the southwest"
		if(SOUTHEAST)
			dirtext = "the southeast"
		else //Where ARE you.
			dirtext = "an unknown direction"

	var/distance = get_dist(ourturf, targetturf)
	var/disttext

	switch(distance)
		if(0 to 20)
			disttext = "20 tiles"
		if(20 to 40)
			disttext = "20 to 40 tiles"
		if(40 to 80)
			disttext = "40 to 80 tiles"
		if(80 to 160)
			disttext = "far"
		else
			disttext = "very far"

	var/place = get_area_name(targetturf)

	var/violation_index = (5-target.masquerade)
	var/violations
	if(violation_index)
		violations = LOWER_TEXT("[GLOB.numbers_as_words[violation_index]]")
	else
		violations = "zero"

	var/returntext

	switch(method)
		if(LOCATOR_MASQ)
			if(isghoul(target) || iskindred(target) || iscathayan(target))
				returntext = "[target.true_real_name] is [disttext] away to [dirtext] in [place]. They have violated the Masquerade [violations] times. They [target.diablerist ? "<b>are</b>" : "are not"] a diablerist."
		if(LOCATOR_BLOODHUNT)
			returntext = "[icon2html(getFlatIcon(target), user)][target.true_real_name], [target.mind ? target.mind.assigned_role : "Citizen"], is [disttext] away to [dirtext] in [place]."
		if(LOCATOR_VEIL)
			if(isgarou(target))
				returntext = "[target.true_real_name] is [disttext] away to [dirtext] in [place]. They have violated the Veil [violations] times."
//		if(LOCATOR_HOWL) // Werewolf code sucks a lot. Don't feel like making this work right now.
//			var/howltype
//			if(isgarou(target))
				returntext = "[target.true_real_name] is [disttext] away to [dirtext] in [place]. They have violated the Veil [violations] times."
		if(LOCATOR_NORM)
			returntext = "[target.true_real_name] is [disttext] away to [dirtext] in [place]."
		else
			return FALSE

	return returntext
