GLOBAL_LIST_EMPTY(unallocated_agility_shortcuts)

/obj/agility_shortcut
	name = "agility shortcut"
	desc = "200 million agility experience required. Tell a coder!"
	icon = 'modular_zapoc/modules/apoc_decor/icons/agility_shortcut.dmi'
	icon_state = "shortcut"
	anchored = TRUE
	pixel_y = 32
	var/obj/agility_shortcut/exit
	var/id
	// If false, scales with athletics
	var/scale_with_distance = FALSE
	// Default do_after timer. A value of 60 takes a 5 athletics character 1 second to enter.
	var/base_timer = 80
	// If not 0, must have at least this much athletics to pass.
	var/minimum_athletics = 0
	// Lists for determining who is allowed to use the shortcut
	var/allowed_species
	var/allowed_bloodlines
	var/allowed_tribes
	var/allowed_jobs
	var/anyone_can_enter

/obj/agility_shortcut/Initialize() // Evil copypaste of transferpoint code
	. = ..()
	if(!exit)
		if(isnum(id))
			warning("[src] has a ID of [id]. Numbers are bad practice")
		GLOB.unallocated_agility_shortcuts += src
		for(var/obj/agility_shortcut/T in GLOB.unallocated_agility_shortcuts)
			if(T.id == id && T != src)
				exit = T
				GLOB.unallocated_agility_shortcuts -= T
				T.exit = src
				GLOB.unallocated_agility_shortcuts -= src
				break

/obj/agility_shortcut/attack_hand(mob/living/user)
	var/time
	var/turf/T = get_turf(exit)
	if(scale_with_distance)
		var/distance_mod = round(get_dist(src.loc, exit.loc) * 2, 10)
		time = base_timer + distance_mod
		var/user_power = user.get_total_athletics()
		time = base_timer - (user_power*10)

	if(validate_allowance(user))
		if(do_after(user, max(base_timer, time), src))
			var/atom/movable/AM
			if(user.pulling)
				AM = user.pulling
				AM.forceMove(T)
			user.forceMove(T)
			if(AM)
				user.start_pulling(AM)
		else
			to_chat(user, span_warning("You stop trying to crawl through the tunnel."))
	else
		to_chat(user, span_warning("No way I'm crawling in there."))

/obj/agility_shortcut/attack_ghost(mob/user)
	. = ..()
	if(.)
		return
	if(exit)
		user.forceMove(get_turf(exit))

/obj/agility_shortcut/proc/validate_allowance(mob/living/user)
	if(!exit)
		return FALSE

	if(anyone_can_enter)
		return TRUE

	if(minimum_athletics && (minimum_athletics > user.get_total_athletics()))
		return FALSE

	if(ishuman(user))
		var/mob/living/carbon/human/mover = user
		if(mover.dna.species in allowed_species)
			return TRUE

		if(mover.clan.name in allowed_bloodlines)
			return TRUE

		if(mover.auspice.tribe.name in allowed_tribes)
			return TRUE

	if("Werewolf" in allowed_species && (isgarou(user) || iswerewolf(user)))
		return TRUE

	if(user.job in allowed_jobs)
		return TRUE

	return FALSE

////* And now, for the subtypes. *////
/obj/agility_shortcut/anyone
	desc = "You could probably fit in there. Want to find out?"
	anyone_can_enter = TRUE

/obj/agility_shortcut/cave
	name = "tunnel"
	desc = "A small hole in the cavern wall. You're not thinking about going in there, right?"
	icon_state = "shortcut"

/obj/agility_shortcut/cave/gaia
	allowed_tribes = TRIBE_GAIA

/obj/agility_shortcut/urban
	name = "hole"
	desc = "There are a bunch of bricks missing. Not enough for you to crawl in. Unless you were insane."
	icon_state = "shortcut_urban"

/obj/agility_shortcut/urban/spiral
	allowed_tribes = TRIBE_WYRM
