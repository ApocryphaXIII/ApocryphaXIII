// Basic ladder. By default links to the z-level above/below.
/obj/structure/ladder
	name = "ladder"
	desc = "A sturdy metal ladder."
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder11"
	base_icon_state = "ladder"
	anchored = TRUE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	///the ladder below this one
	VAR_FINAL/obj/structure/ladder/down
	///the ladder above this one
	VAR_FINAL/obj/structure/ladder/up
	/// Ladders crafted midround can only link to other ladders crafted midround
	var/crafted = FALSE
	/// travel time for ladder in deciseconds
	var/travel_time = 1 SECONDS
	// Requires a sister ladder to link up with us else we runtime
	var/requires_friend = FALSE

/obj/structure/ladder/Initialize(mapload, obj/structure/ladder/up, obj/structure/ladder/down)
	..()
	GLOB.ladders += src
	if(up)
		link_up(up)
	if(down)
		link_down(down)

	return INITIALIZE_HINT_LATELOAD

/obj/structure/ladder/Destroy(force)
	// ! This feels useless, this behavoir SHOULD already exist on obj or structure
	if ((resistance_flags & INDESTRUCTIBLE) && !force)
		return QDEL_HINT_LETMELIVE

	GLOB.ladders -= src
	disconnect()
	return ..()

/// Links this ladder to passed ladder (which should generally be below it)
/obj/structure/ladder/proc/link_down(obj/structure/ladder/down_ladder)
	if(down)
		return

	down = down_ladder
	down_ladder.up = src
	down_ladder.update_appearance(UPDATE_ICON_STATE)
	update_appearance(UPDATE_ICON_STATE)
	//make_base_transparent()

/// Unlinks this ladder from the ladder below it.
/obj/structure/ladder/proc/unlink_down()
	if(!down)
		return

	down.up = null
	down.update_appearance(UPDATE_ICON_STATE)
	down = null
	update_appearance(UPDATE_ICON_STATE)
	//clear_base_transparency()

/// Links this ladder to passed ladder (which should generally be above it)
/obj/structure/ladder/proc/link_up(obj/structure/ladder/up_ladder)
	if(up)
		return

	up = up_ladder
	up_ladder.down = src
	//p_ladder.make_base_transparent()
	up_ladder.update_appearance(UPDATE_ICON_STATE)
	update_appearance(UPDATE_ICON_STATE)

/// Unlinks this ladder from the ladder above it.
/obj/structure/ladder/proc/unlink_up()
	if(!up)
		return

	up.down = null
	//up.clear_base_transparency()
	up.update_appearance(UPDATE_ICON_STATE)
	up = null
	update_appearance(UPDATE_ICON_STATE)

/// Helper to unlink everything
/obj/structure/ladder/proc/disconnect()
	unlink_down()
	unlink_up()

/obj/structure/ladder/LateInitialize()
	// By default, discover ladders above and below us vertically
	var/turf/base = get_turf(src)

	if(isnull(down))
		// ! Swap to GET_TURF_BELOW(base)
		var/obj/structure/ladder/new_down = locate() in SSmapping.get_turf_below(base)
		if (new_down && crafted == new_down.crafted)
			link_down(new_down)

	if(isnull(up))
		// ! Swap to GET_TURF_ABOVE(base)
		var/obj/structure/ladder/new_up = locate() in SSmapping.get_turf_above(base)
		if (new_up && crafted == new_up.crafted)
			link_up(new_up)

	// Linking updates our icon, so if we failed both links we need a manual update
	if(isnull(down) && isnull(up))
		update_appearance(UPDATE_ICON_STATE)
		if(requires_friend)
			CRASH("[src] failed to find another ladder to link up with.")

/obj/structure/ladder/update_icon_state()
	icon_state = "[base_icon_state][!!up][!!down]"
	return ..()

/obj/structure/ladder/proc/travel(going_up, mob/user, is_ghost, obj/structure/ladder/ladder)
	if(!is_ghost)
		show_fluff_message(user, ladder, going_up)
		ladder.add_fingerprint(user)

	var/turf/T = get_turf(ladder)
	var/atom/movable/AM
	if(user.pulling)
		AM = user.pulling
		AM.forceMove(T)
	user.forceMove(T)
	if(AM)
		user.start_pulling(AM)

	//reopening ladder radial menu ahead
	T = get_turf(user)
	var/obj/structure/ladder/ladder_structure = locate() in T
	if (ladder_structure)
		ladder_structure.use(user)

/obj/structure/ladder/proc/use(mob/user, is_ghost=FALSE)
	if(!in_range(src, user) || DOING_INTERACTION(user, DOAFTER_SOURCE_CLIMBING_LADDER))
		return

	show_options(is_ghost)

	if(!is_ghost)
		add_fingerprint(user)

/obj/structure/ladder/proc/start_travelling(mob/user, going_up)
	if(do_after(user, travel_time, target = src, interaction_key = DOAFTER_SOURCE_CLIMBING_LADDER))
		travel(user, going_up, grant_exp = TRUE)

/// Shows a radial menu that players can use to climb up and down a stair.
/obj/structure/ladder/proc/show_options(mob/user, is_ghost = FALSE)
	var/list/tool_list = list()
	tool_list["Up"] = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = NORTH)
	tool_list["Down"] = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = SOUTH)

	var/datum/callback/check_menu
	if(!is_ghost)
		check_menu = CALLBACK(src, PROC_REF(check_menu), user)
	var/result = show_radial_menu(user, src, tool_list, custom_check = check_menu, require_near = !is_ghost, tooltips = TRUE)

	var/going_up
	switch(result)
		if("Up")
			going_up = TRUE
		if("Down")
			going_up = FALSE
		else
			return

	if(is_ghost || !travel_time)
		travel(user, going_up, is_ghost)
	else
		INVOKE_ASYNC(src, PROC_REF(start_travelling), user, going_up)

/obj/structure/ladder/proc/check_menu(mob/user, is_ghost)
	if(user.incapacitated() || (!user.Adjacent(src)))
		return FALSE
	return TRUE

/obj/structure/ladder/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	use(user)

/obj/structure/ladder/attack_paw(mob/user)
	return use(user)

/obj/structure/ladder/attack_alien(mob/user)
	return use(user)

/obj/structure/ladder/attackby(obj/item/W, mob/user, params)
	return use(user)

/obj/structure/ladder/attack_robot(mob/living/silicon/robot/R)
	if(R.Adjacent(src))
		return use(R)

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/structure/ladder/attack_ghost(mob/dead/observer/user)
	use(user, TRUE)
	return ..()

/obj/structure/ladder/proc/show_fluff_message(mob/user, obj/structure/ladder/destination, going_up)
	if(going_up)
		user.visible_message("<span class='notice'>[user] climbs up [src].</span>", "<span class='notice'>You climb up [src].</span>")
	else
		user.visible_message("<span class='notice'>[user] climbs down [src].</span>", "<span class='notice'>You climb down [src].</span>")

// Indestructible away mission ladders which link based on a mapped ID and height value rather than X/Y/Z.
/obj/structure/ladder/unbreakable
	name = "sturdy ladder"
	desc = "An extremely sturdy metal ladder."
	resistance_flags = INDESTRUCTIBLE
	var/id
	var/height = 0  // higher numbers are considered physically higher

/obj/structure/ladder/unbreakable/Destroy()
	. = ..()
	if (. != QDEL_HINT_LETMELIVE)
		GLOB.ladders -= src

/obj/structure/ladder/unbreakable/LateInitialize()
	// Override the parent to find ladders based on being height-linked
	if (!id || (up && down))
		update_icon()
		return

	for (var/O in GLOB.ladders)
		var/obj/structure/ladder/unbreakable/L = O
		if (L.id != id)
			continue  // not one of our pals
		if (!down && L.height == height - 1)
			down = L
			L.up = src
			L.update_icon()
			if (up)
				break  // break if both our connections are filled
		else if (!up && L.height == height + 1)
			up = L
			L.down = src
			L.update_icon()
			if (down)
				break  // break if both our connections are filled

	update_icon()

/obj/structure/ladder/crafted
	crafted = TRUE
