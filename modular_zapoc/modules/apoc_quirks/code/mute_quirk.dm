/datum/quirk/mute
	name = "Mute"
	desc = "You can't speak, but you know sign language!"
	value = -3
	gain_text = "<span class='warning'>You feel quiet.</span>"
	lose_text = "<span class='notice'>You feel like saying something.</span>"

/datum/quirk/mute/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/organ/tongue = H.getorganslot(ORGAN_SLOT_TONGUE)
	var/obj/item/organ/new_tongue = new /obj/item/organ/tongue/tied
	new_tongue.Insert(H)
	qdel(tongue)
