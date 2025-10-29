/datum/quirk/kinfolk
	name = "Kinfolk"
	desc = "You are kinfolk. Garou and others who can smell your nature will know this."
	value = 2
	mob_trait = TRAIT_KINFOLK
	gain_text = "<span class='notice'>You smell like wet dog.</span>"
	lose_text = "<span class='warning'>You don't smell like wet dog anymore.</span>"
	allowed_species = list("Human")

/datum/quirk/kinfolk/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/garou_tongue)
//	H.grant_language(/datum/language/primal_tongue) // Bandaid
