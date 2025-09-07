/datum/quirk/blind
	name = "Blind"
	desc = "Your eyes either don't work or are missing. Maybe you should bring a cane."
	value = -4
	gain_text = "<span class='warning'>You can't see.</span>"
	lose_text = "<span class='notice'>You can see!</span>"


/datum/quirk/blind/on_process()
	var/mob/living/carbon/human/H = quirk_holder

	var/holding_cane
	for(var/obj/item/cane/i in H.held_items)
		if(istype(i, /obj/item/cane) && i.extended)
			holding_cane = TRUE
		else
			holding_cane = FALSE

	if(!holding_cane && H.eye_blurry < 2)
		H.set_blurriness(2)
