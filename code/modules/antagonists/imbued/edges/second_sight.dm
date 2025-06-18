/datum/action/imbued_edge/second_sight
	name = "Second Sight"
	edge_dots = IMBUED_POWER_INNATE

//Yea. not great but this SHOULD be only only instance of it
/datum/action/imbued_edge/second_sight/get_conviction_cost()
	return 1

/datum/action/imbued_edge/second_sight/edge_action(mob/living/user, mob/living/target)
	if(user.has_status_effect(STATUS_EFFECT_SECOND_SIGHT))
		to_chat(user, span_warning("You can already see second sight"))
		return
	. = ..()
	to_chat(user, span_notice("You activate second sight"))
	user.apply_status_effect(STATUS_EFFECT_SECOND_SIGHT)
	return TRUE

/datum/status_effect/second_sight
	id = "second_sight"
	duration = 10 SECONDS
