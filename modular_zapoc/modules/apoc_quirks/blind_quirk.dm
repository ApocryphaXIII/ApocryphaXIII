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
	var/obj/item/cane/cane
	if(!istype(H.get_active_held_item(), /obj/item/cane) && !istype(H.get_inactive_held_item(), /obj/item/cane))
		H.set_blurriness(5)
