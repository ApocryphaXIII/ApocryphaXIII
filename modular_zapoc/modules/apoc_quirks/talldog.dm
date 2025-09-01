/datum/werewolf_holder/transformation/transform(mob/living/carbon/trans, form) // APOC EDIT START
	if(trans.istower)
		trans.remove_quirk(/datum/quirk/tower,TRUE)
	. = ..()
