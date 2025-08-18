/datum/smite/imbue
	name = "Imbue"

/datum/smite/imbue/effect(client/user, mob/living/target)
	. = ..()
	if(!ishuman(target))
		return
	target.set_species(/datum/species/human/imbued)
	target.adjust_disgust(100)
