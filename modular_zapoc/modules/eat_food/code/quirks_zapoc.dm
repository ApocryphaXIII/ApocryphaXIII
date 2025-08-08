/datum/quirk/eat_food
	name = "Eat Food"
	desc = "Can consume food but still with no nourishment."
	value = 0
	gain_text = "<span class='notice'>You could go for some real food.</span>"
	lose_text = "<span class='notice'>You don't want any more real food.</span>"
	mob_trait = TRAIT_CAN_EAT
	allowed_species = list("Vampire")

/datum/quirk/eat_food/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.dna.species.toxic_food = NONE

/datum/reagent/on_mob_add(mob/living/L) // This is probably the worst code I've ever written
	. = ..()
	if(iskindred(L)) // are they a vampire?
		if(HAS_TRAIT(L, TRAIT_CAN_EAT)) // do they have Eat Food?
			if(type == /datum/reagent/consumable/ethanol/beer/typhon) // Typhon beer is OK for vampires to metabolize
				return
			else
				holder.remove_reagent(type, INFINITY) // There's a better way to do this
