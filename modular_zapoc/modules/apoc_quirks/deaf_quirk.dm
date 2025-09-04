/datum/quirk/Deaf
	name = "Deaf"
	desc = "Your ears don't pick up sound very well. A hearing aid might help..."
	value = -3
	gain_text = span_notice("You can't hear.")
	lose_text = span_notice("You can hear!")

/datum/quirk/deaf/on_process()
	var/mob/living/carbon/human/H = quirk_holder

	if(!(HAS_TRAIT(H, TRAIT_DEAF) && HAS_TRAIT_FROM(H, TRAIT_DEAF, "quirk")) && !istype(H.ears, /obj/item/clothing/ears/hearing_aid))
		ADD_TRAIT(H, TRAIT_DEAF, "quirk")
	else if(!istype(H.ears, /obj/item/clothing/ears/hearing_aid))
		REMOVE_TRAIT(H, TRAIT_DEAF, "quirk")
