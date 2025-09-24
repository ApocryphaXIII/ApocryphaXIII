/datum/quirk/wolf_sight
	name = "Wolf Sight"
	desc = "Your eyes in have a tapetum lucidum. See in the dark."
	value = 2
	gain_text = "<span class='notice'>You have the eyes of the wolf.</span>"
	lose_text = "<span class='warning'>Your eyes aren't \'of the wolf\' anymore.</span>"
	allowed_species = ("Werewolf")

/datum/quirk/wolf_sight/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/organ/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	var/obj/item/organ/new_eyes = new /obj/item/organ/eyes/night_vision
	new_eyes.Insert(H)
	qdel(eyes)

