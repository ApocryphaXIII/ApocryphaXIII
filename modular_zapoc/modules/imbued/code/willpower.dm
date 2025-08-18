/mob/living/proc/adjust_willpower(amount, override_cap)
	if(!isnum(amount))
		return
	willpower = clamp(willpower + amount, 0, total_willpower)
