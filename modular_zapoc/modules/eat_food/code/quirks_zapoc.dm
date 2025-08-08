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

/* Eventually I would like to allow Eat Food vampires to metabolize reagents sans effects. This seems difficult to do and is far out of scope currently.

H.getorganslot(ORGAN_SLOT_STOMACH).metabolism_efficiency = 0.1


/datum/species/kindred
mutant_stomach = /obj/item/organ/stomach/vampire

/obj/item/organ/stomach/vampire
	metabolism_efficiency = 0 // Non Eat Food vampires must vomit to clear space in their stomach

*/
