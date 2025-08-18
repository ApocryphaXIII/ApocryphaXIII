/mob/living/carbon/proc/update_second_sight()
	var/image/holder = hud_list[SECOND_SIGHT_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon = 'icons/effects/effects.dmi'
	if(!ishuman(src))
		holder.icon_state = "blessed"
	else
		holder.icon_state = ""
