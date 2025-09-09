/datum/quirk/deaf
	name = "Deaf"
	desc = "Your ears don't pick up sound very well. A hearing aid might help..."
	value = -3
	gain_text = "<span class='warning'>You can't hear.</span>"
	lose_text = "<span class='notice'>You can hear!</span>"

/datum/quirk/deaf/on_process()
	var/mob/living/carbon/human/H = quirk_holder

	if(!(HAS_TRAIT(H, TRAIT_DEAF) && HAS_TRAIT_FROM(H, TRAIT_DEAF, "quirk")) && !istype(H.ears, /obj/item/clothing/ears/hearing_aid))
		ADD_TRAIT(H, TRAIT_DEAF, "quirk")
	else if(istype(H.ears, /obj/item/clothing/ears/hearing_aid))
		REMOVE_TRAIT(H, TRAIT_DEAF, "quirk")

/datum/quirk/deaf/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(HAS_TRAIT(H, TRAIT_DEAF))
		REMOVE_TRAIT(H, TRAIT_DEAF, "quirk")
