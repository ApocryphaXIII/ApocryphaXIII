/mob/living/proc/adjust_conviction(amount, override_cap)
	if(!isnum(amount))
		return
	conviction = clamp(conviction + amount, 0, total_conviction)
	if(!GLOB.canon_event)
		return
	var/datum/preferences/P = GLOB.preferences_datums[ckey(key)]
	if(P)
		P.conviction = conviction
		P.save_character()
