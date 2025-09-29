
/obj/structure/sign/flag
	name = "blank flag"
	desc = "The flag of nothing. It has nothing on it. Magnificient."
	//icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "flag_coder"
	buildable_sign = FALSE
	custom_materials = null
	var/item_flag = /obj/item/sign/flag

/obj/structure/sign/flag/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

// TODO: [Rebase] MouseDrop : mouse_drop_dragged
/obj/structure/sign/flag/MouseDrop(atom/over, mob/user, src_location, over_location, params)
	if(over == user && Adjacent(user))
		//if(!item_flag || src.obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
		//	return
		//if(!user.can_perform_action(src, NEED_DEXTERITY))
		//	return
		user.visible_message(span_notice("[user] grabs and folds \the [src.name]."), span_notice("You grab and fold \the [src.name]."))
		var/obj/item/flag_item = new item_flag(loc)
		TransferComponents(flag_item)
		user.put_in_hands(flag_item)
		qdel(src)

// HORIZONTAL

/obj/structure/sign/flag/pride
	name = "coder pride flag"
	desc = "You probably shouldn't be seeing this. Yell at the coders about it."
	icon = 'modular_zapoc/modules/pride_flags/icons/pride_flags.dmi'

// TODO: [Rebase] AltClick gets replaced with click_alt in TG
/obj/structure/sign/flag/pride/AltClick(mob/user)
	var/init_icon_state = initial(icon_state)
	if(icon_state == init_icon_state)
		icon_state = "[icon_state]_verticle"
	else
		icon_state = init_icon_state
	. = ..()

/obj/structure/sign/flag/pride/gay
	name = "gay pride flag"
	desc = "The flag of gay pride."
	icon_state = "flag_pride"
	item_flag = /obj/item/sign/flag/pride/gay

/obj/structure/sign/flag/pride/ace
	name = "asexual pride flag"
	desc = "The flag of asexual pride."
	icon_state = "flag_ace"
	item_flag = /obj/item/sign/flag/pride/ace

/obj/structure/sign/flag/pride/bi
	name = "bisexual pride flag"
	desc = "The flag of bisexual pride."
	icon_state = "flag_bi"
	item_flag = /obj/item/sign/flag/pride/bi

/obj/structure/sign/flag/pride/lesbian
	name = "lesbian pride flag"
	desc = "The flag of lesbian pride."
	icon_state = "flag_lesbian"
	item_flag = /obj/item/sign/flag/pride/lesbian

/obj/structure/sign/flag/pride/pan
	name = "pansexual pride flag"
	desc = "The flag of pansexual pride."
	icon_state = "flag_pan"
	item_flag = /obj/item/sign/flag/pride/pan

/obj/structure/sign/flag/pride/trans
	name = "trans pride flag"
	desc = "The flag of trans pride."
	icon_state = "flag_trans"
	item_flag = /obj/item/sign/flag/pride/trans

// FOLDED

/obj/item/sign/flag
	name = "folded blank flag"
	desc = "The folded flag of nothing. It has nothing on it. Beautiful."
	//icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "folded_coder"
	sign_path = /obj/structure/sign/flag
	is_editable = FALSE

///Since all of the signs rotate themselves on initialisation, this made folded flags look ugly (and more importantly rotated).
///And thus, it gets removed to make them aesthetically pleasing once again.
/obj/item/sign/flag/Initialize(mapload)
	. = ..()
	var/matrix/rotation_reset = matrix()
	rotation_reset.Turn(0)
	transform = rotation_reset

/obj/item/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/*
/obj/item/sign/set_sign_type(obj/structure/sign/fake_type)
	. = ..()
	icon = initial(fake_type.icon)
*/

/obj/item/sign/flag/pride
	name = "folded coder pride flag"
	desc = "You probably shouldn't be seeing this. Yell at the coders about it."
	icon = 'modular_zapoc/modules/pride_flags/icons/pride_flags.dmi'

/obj/item/sign/flag/pride/gay
	name = "folded gay pride flag"
	desc = "The folded flag of gay pride."
	icon_state = "folded_pride"
	sign_path = /obj/structure/sign/flag/pride/gay

/obj/item/sign/flag/pride/ace
	name = "folded asexual pride flag"
	desc = "The folded flag of asexual pride."
	icon_state = "folded_pride_ace"
	sign_path = /obj/structure/sign/flag/pride/ace

/obj/item/sign/flag/pride/bi
	name = "folded bisexual pride flag"
	desc = "The folded flag of bisexual pride."
	icon_state = "folded_pride_bi"
	sign_path = /obj/structure/sign/flag/pride/bi

/obj/item/sign/flag/pride/lesbian
	name = "folded lesbian pride flag"
	desc = "The folded flag of lesbian pride."
	icon_state = "folded_pride_lesbian"
	sign_path = /obj/structure/sign/flag/pride/lesbian

/obj/item/sign/flag/pride/pan
	name = "folded pansexual pride flag"
	desc = "The folded flag of pansexual pride."
	icon_state = "folded_pride_pan"
	sign_path = /obj/structure/sign/flag/pride/pan

/obj/item/sign/flag/pride/trans
	name = "folded trans pride flag"
	desc = "The folded flag of trans pride."
	icon_state = "folded_pride_trans"
	sign_path = /obj/structure/sign/flag/pride/trans
