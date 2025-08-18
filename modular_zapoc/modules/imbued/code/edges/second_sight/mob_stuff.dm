/mob/living/carbon/proc/update_second_sight()
	var/datum/atom_hud/second_sight/hud = GLOB.huds[DATA_HUD_SECOND_SIGHT]
	hud.add_to_hud(src)

	var/image/holder = hud_list[SECOND_SIGHT_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon = 'icons/effects/effects.dmi'
	if(!ishumanbasic(src))
		holder.icon_state = "blessed"
	else
		holder.icon_state = ""
