/datum/action/imbued_edge/reach
	name = "Reach"
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

/datum/status_effect/imbued/reach/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_XRAY_VISION, IMBUED_TRAIT)
	owner.update_sight()

	owner.regenerate_icons()
	owner.client.view_size.zoomOut(2.5)

/datum/status_effect/imbued/reach/on_remove()
	REMOVE_TRAIT(owner, TRAIT_XRAY_VISION, IMBUED_TRAIT)
	owner.update_sight()

	owner.regenerate_icons()
	owner.client.view_size.zoomIn()
	return ..()

/datum/action/imbued_edge/send
	name = "Send"
	related_creed = CREED_HERMIT
	edge_dots = 2

/datum/action/imbued_edge/send/edge_action(mob/living/user, mob/living/target)
	var/mob/living/M = tgui_input_list(user, "Pick a target", "Target Selection", get_hearers_in_view(7, user))
	if(!M)
		return
	var/msg = tgui_input_text(user, "What do you wish to tell [M]?", "Send")
	if(!msg)
		return
	. = ..()
	log_directed_talk(user, M, msg, LOG_SAY, "[name]")
	to_chat(user, span_hypnophrase("[msg]"))
	to_chat(M, "[span_hypnophrase("You hear a voice in your head...")] [span_notice(msg)]")

/datum/action/imbued_edge/edict
	name = "Edict"
	related_creed = CREED_HERMIT
	edge_dots = 3

/datum/action/imbued_edge/transcend
	name = "Transcend"
	related_creed = CREED_HERMIT
	edge_dots = 4

/datum/action/imbued_edge/proclaim
	name = "Proclaim"
	related_creed = CREED_HERMIT
	edge_dots = 5
