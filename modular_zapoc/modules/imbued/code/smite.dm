/datum/smite/imbue
	name = "Imbue"

/datum/smite/imbue/effect(client/user, mob/living/target)
	. = ..()
	if(!ishuman(target))
		return
	target.set_species(/datum/species/human/imbued)
	target.apply_status_effect(/datum/status_effect/imbued/second_sight/long)
	//target.adjust_disgust(100)
