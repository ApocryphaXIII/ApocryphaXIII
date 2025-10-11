/datum/movespeed_modifier/rubicon
	multiplicative_slowdown = 4

/datum/status_effect/rubicon
	id = "rubicon"
	status_type = STATUS_EFFECT_REFRESH
	examine_text = "<span class='warning'>SUBJECTPRONOUN is splashing around like they don't know how to swim.</span>"
	alert_type = /atom/movable/screen/alert/status_effect/fear

/datum/status_effect/rubicon/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/rubicon)

/datum/status_effect/rubicon/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/rubicon)
