/datum/quirk/relshab
	name = "Ban (Relshab)"
	desc = "Greedily consume any food you can get your hands on without getting full."
	value = 2
	gain_text = "<span class='warning'>You're ravenously hungry.</span>"
	lose_text = "<span class='notice'>You aren't hungry anymore.</span>"
	mob_trait = TRAIT_RELSHAB
	allowed_species = list("Werewolf")
	allowed_tribes = list(TRIBE_BLACKSPIRALDANCERS)

/datum/quirk/relshab/on_spawn() //these should only trigger when the character is being created for the first time, i.e. roundstart/latejoin
	ADD_TRAIT(quirk_holder, TRAIT_VORACIOUS, "quirk")

/datum/quirk/relshab/remove() //special "on remove" effects
	REMOVE_TRAIT(quirk_holder, TRAIT_VORACIOUS, list("quirk"))

/datum/quirk/relshab/on_process()
	if(ishuman(quirk_holder))
		var/mob/living/carbon/human/hongry = quirk_holder
		if(hongry.nutrition > 520)
			hongry.nutrition = 520
