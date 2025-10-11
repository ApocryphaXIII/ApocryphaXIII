/datum/quirk/animal_musk
	name = "Animal Musk"
	desc = "You smell awful, and everyone knows it."
	mob_trait = TRAIT_ANIMAL_MUSK
	value = 0
	gain_text = "<span class='notice'>You feel smelly.</span>"
	lose_text = "<span class='warning'>You feel clean.</span>"

/datum/quirk/animal_musk/fera
	name = "Animal Musk (Fera)"
	desc = "You smell like an animal, and everyone knows it."
	value = -1
	allowed_species = list("Werewolf")
