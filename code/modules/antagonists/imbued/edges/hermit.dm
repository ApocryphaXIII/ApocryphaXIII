/datum/action/imbued_edge/reach
	related_creed = CREED_HERMIT
	edge_dots = 1

/datum/action/imbued_edge/reach/edge_action(mob/living/user, mob/living/target)
	if(user.has_status_effect(/datum/status_effect/imbued/reach))
		to_chat(user, span_warning("You can already see second sight"))
		return
	. = ..()
	to_chat(user, span_notice("You activate second sight"))
	user.apply_status_effect(/datum/status_effect/imbued/reach)
	return TRUE

/datum/status_effect/imbued/reach
	id = "imbued_reach"
	duration = 20 SECONDS

/datum/action/imbued_edge/send
	related_creed = CREED_HERMIT
	edge_dots = 2

/datum/action/imbued_edge/edict
	related_creed = CREED_HERMIT
	edge_dots = 3

/datum/action/imbued_edge/transcend
	related_creed = CREED_HERMIT
	edge_dots = 4

/datum/action/imbued_edge/proclaim
	related_creed = CREED_HERMIT
	edge_dots = 5
