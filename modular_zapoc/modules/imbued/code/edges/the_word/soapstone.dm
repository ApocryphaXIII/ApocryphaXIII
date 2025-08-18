/obj/item/soapstone/the_word
	name = "pointed hand"
	desc = "A hand prepared to write the word."
	icon_state = "duffelcurse"
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	tool_speed = 0.5 SECONDS
	remaining_uses = -1
	chisel_type = /obj/structure/chisel_message/the_word

/obj/structure/chisel_message/the_word
	//The word is boring and mudane to non-imbued
	color = COLOR_GRAY
	//Imbued are a rare breed. It should not take many to remove a message.
	delete_at = -1
	the_word = TRUE
	hud_possible = list(SECOND_SIGHT_HUD)

/obj/structure/chisel_message/the_word/Initialize(mapload)
	. = ..()
	prepare_huds()

	#warn likely unneeded
	var/datum/atom_hud/second_sight/hud = GLOB.huds[DATA_HUD_SECOND_SIGHT]
	hud.add_to_hud(src)

	var/image/holder = hud_list[SECOND_SIGHT_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon = 'icons/effects/effects.dmi'
	holder.icon_state = "blessed"
	/*
	holder.layer = ABOVE_OPEN_TURF_LAYER
	holder.plane = GAME_PLANE
	holder.loc = src
	holder.appearance_flags = RESET_ALPHA
	*/
/*
	var/image/I = image(icon = 'icons/effects/effects.dmi', icon_state = "blessed", layer = ABOVE_OPEN_TURF_LAYER, loc = src)
	I.alpha = 255
	I.appearance_flags = RESET_ALPHA
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/the_word, "blessing", I)
*/

/obj/structure/chisel_message/the_word/can_read_message(mob/user)
	return isimbued(user)

/obj/structure/chisel_message/the_word/update_message_apperance()
	return

/*
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
*/
