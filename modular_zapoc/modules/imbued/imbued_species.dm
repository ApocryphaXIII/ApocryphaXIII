/datum/species/human/imbued
	name = "Imbued"
	id = "imbued"

/datum/species/human/imbued/on_species_gain(mob/living/carbon/human/C)
	for(var/datum/action/imbued_edge/path as anything in C.imbued_powers)
		if(initial(path.edge_dots) != IMBUED_POWER_INNATE)
			continue

		var/datum/action/imbued_edge/innate_ability = new path()
		innate_ability.on_purchase(C, TRUE)

/datum/species/human/imbued/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	for(var/datum/action/imbued_edge/edge_action in C.actions)
		edge_action.Remove(C)
