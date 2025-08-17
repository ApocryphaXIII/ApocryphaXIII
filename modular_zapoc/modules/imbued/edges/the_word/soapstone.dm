/obj/item/soapstone/the_word
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	tool_speed = 0.5 SECONDS
	remaining_uses = 1
	chisel_type = /obj/structure/chisel_message/the_word

/obj/structure/chisel_message/the_word
	the_word = TRUE

/obj/structure/chisel_message/the_word/Initialize(mapload)
	. = ..()
	var/image/I = image(icon = 'icons/effects/effects.dmi', icon_state = "blessed", layer = ABOVE_OPEN_TURF_LAYER, loc = src)
	I.alpha = 255
	I.appearance_flags = RESET_ALPHA
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/the_word, "blessing", I)

/obj/structure/chisel_message/the_word/can_read_message(mob/user)
	return isimbued(user)

/datum/atom_hud/alternate_appearance/basic/the_word

/datum/atom_hud/alternate_appearance/basic/the_word/New()
	..()
	for(var/mob in GLOB.player_list)
		if(mobShouldSee(mob))
			add_hud_to(mob)

/datum/atom_hud/alternate_appearance/basic/the_word/mobShouldSee(mob/M)
	if(isimbued(M))
		return TRUE
	return FALSE
