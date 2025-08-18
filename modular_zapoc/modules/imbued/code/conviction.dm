/mob/living/proc/adjust_conviction(amount, override_cap)
	if(!isnum(amount))
		return
	conviction = clamp(conviction + amount, 0, total_conviction)
