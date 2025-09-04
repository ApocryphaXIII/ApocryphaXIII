/datum/quirk/blind
	name = "Blind"
	desc = "Your eyes either don't work or are missing. Maybe you should bring a cane."
	value = -4
	gain_text = span_notice("You can't see.")
	lose_text = span_notice("You can see!")


/datum/quirk/blind/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	var/obj/item/organ/ears/ears = H.getorganslot(ORGAN_SLOT_EARS)
	eyes.damage = ears.damage

	var/holding_cane
	for(var/obj/item/cane/i in H.held_items)
		if(istype(i, /obj/item/cane) && i.extended)
			holding_cane = TRUE
		else
			holding_cane = FALSE

	if(holding_cane)
		H.set_blurriness(0)
	else
		H.set_blurriness(2)
