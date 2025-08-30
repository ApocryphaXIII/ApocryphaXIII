/mob/living/proc/adjust_willpower(amount, override_cap)
	if(!isnum(amount))
		return
	willpower = clamp(willpower + amount, 0, total_willpower)
	if(!GLOB.canon_event)
		return
	var/datum/preferences/P = GLOB.preferences_datums[ckey(key)]
	if(P)
		P.willpower = willpower
		P.save_character()
