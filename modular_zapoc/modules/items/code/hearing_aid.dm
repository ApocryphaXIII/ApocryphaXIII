/obj/item/clothing/ears/hearing_aid
	name = "hearing aid"
	desc = "Put it in your ear to aid your hearing. Won't help hearing loss caused by physical damage."
	icon = 'modular_zapoc/modules/items/icons/hearing_aid.dmi'
	icon_state = "hearing_aid"
	base_icon_state = "hearing_aid"
	worn_icon = 'modular_zapoc/modules/items/icons/hearing_aid_worn.dmi'
	onflooricon = 'modular_zapoc/modules/items/icons/hearing_aid_onfloor.dmi'
	onflooricon_state = "hearing_aid"
	inhand_icon_state = "nothing"
	var/flipped = FALSE

/obj/item/clothing/ears/hearing_aid/equipped(mob/M, slot)
	var/sources = list(GENETIC_MUTATION, "quirk")
	REMOVE_TRAIT(M, TRAIT_DEAF, sources)
	. = ..()



/obj/item/clothing/ears/hearing_aid/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to flip the hearing aid to the other ear.")


/obj/item/clothing/ears/hearing_aid/AltClick(mob/user)
	if(isliving(user))
		swap_ear(user)


/obj/item/clothing/ears/hearing_aid/proc/swap_ear(mob/user)
	flipped = !flipped
	icon_state = flipped ? "[base_icon_state]_flipped" : base_icon_state
	if (!ismob(user))
		return
	var/mob/living/carbon/human/H = user
	H.regenerate_icons()
