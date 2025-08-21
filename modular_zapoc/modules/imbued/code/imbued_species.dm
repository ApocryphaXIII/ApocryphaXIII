/datum/species/human/imbued
	name = "Imbued"
	id = "imbued"
	limbs_id = "human"

/datum/species/human/imbued/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_IMBUED]
	hud.add_hud_to(C)
	C.update_sight()
	for(var/datum/action/imbued_edge/path as anything in C.imbued_powers)
		if(initial(path.edge_dots) != IMBUED_POWER_INNATE)
			continue

		var/datum/action/imbued_edge/innate_ability = new path()
		innate_ability.on_purchase(C, TRUE)

	// Gain some extra conviction back on roundstart
	C.adjust_conviction(CONVICTION_REGAIN)

/datum/species/human/imbued/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_IMBUED]
	hud.remove_hud_from(C)
	C.update_sight()
	for(var/datum/action/imbued_edge/edge_action in C.actions)
		edge_action.Remove(C)
