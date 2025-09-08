/obj/item/cane/white
	name = "white cane"
	desc = "Traditionally used by the blind to help them see. Folds down to be easier to transport."
	icon = 'modular_zapoc/modules/items/icons/canes.dmi'
	icon_state = "cane_white"
	base_icon_state = "cane_white"
//	onflooricon = 'modular_zapoc/modules/items/icons/canes_onfloor.dmi' // Don't have an onfloor yet.
	lefthand_file = 'modular_zapoc/modules/items/icons/canes_lefthand.dmi'
	righthand_file = 'modular_zapoc/modules/items/icons/canes_righthand.dmi'
	force = 1
	grid_height = 2
	w_class = WEIGHT_CLASS_SMALL
	extended = FALSE

/obj/item/cane/white/AltClick(mob/user)
	. = ..()
	extend_cane(user)

/obj/item/cane/white/attack_self(mob/user)
	. = ..()
	extend_cane(user)

/obj/item/cane/white/proc/extend_cane(mob/user)
	if(user.get_active_held_item() == src || user.get_inactive_held_item() == src)
		if(extended == FALSE)
			icon_state = "[base_icon_state]_on"
			inhand_icon_state = "[base_icon_state]_on"
			force = 5
			w_class = WEIGHT_CLASS_BULKY
			grid_height = 10
			extended = TRUE
		else
			icon_state = "[base_icon_state]"
			inhand_icon_state = "[base_icon_state]"
			grid_height = 2
			force = initial(force)
			w_class = initial(w_class)
			extended = FALSE
		playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, TRUE)
	else
		to_chat(user, span_warning("You'll want to hold the [src] in your hand before trying to [extended ? "fold" : "extend"] it."))
