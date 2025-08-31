/obj/isekai_truck
	name = "truck-kun"
	desc = "A truck that will surely whisk you away to a fantasy world full of gullible women with large breasts."
	icon = 'modular_zapoc/modules/apoc_vehicles/icons/admin_truck.dmi'
	icon_state = "track_bacotell"
	movement_type = PHASING
	pixel_x = -32
	pixel_y = -32
	layer = INFINITY

	var/mob/living/truck_target
	var/bonk_played
	var/isekai
	var/lifespan
	var/touched_target


///obj/isekai_truck/Initialize(mapload)
//	. = ..()
//	spawn(10 SECONDS)
//		qdel(src)


/obj/isekai_truck/Bump()
	. = ..()
	playsound(src, 'code/modules/wod13/sounds/bump.ogg', 75, TRUE)


/obj/isekai_truck/Move(Dir)
	dir = Dir
	if(touched_target)
		lifespan--
	if((loc == truck_target.loc))
		touched_target = TRUE
		if(!bonk_played)
			playsound(src, 'code/modules/wod13/sounds/bump.ogg', 75, TRUE)
			bonk_played = TRUE
		if(isekai)
			var/mob/living/target = truck_target
			target.move_to_error_room()

	if(lifespan <= 0)
		spawn(1)
			qdel(src)

	. = ..()


/datum/smite/isekai
	name = "isekai"

	var/spawndir_choice
	var/spawndir
	var/spawndist = 7
	var/quick_truck
	var/abort
	var/isekai
	var/isekai_choice
	var/all_directions = list("NORTH", "SOUTH", "EAST", "WEST")


/datum/smite/isekai/configure(client/user)
	quick_truck = (alert(user, "Skip setup?", "the crystal", "Yes", "No", "Cancel"))
	if(quick_truck == "No")
		spawndir_choice = input(user, "Choose a direction for the truck to come from.") in all_directions
		isekai_choice = (alert(user, "Send to a mystical fantasy realm?", "isekai", "Yes", "No"))
		abort = (alert(user, "Direction: [spawndir_choice]. Distance: [spawndist]. Isekai: [isekai_choice]. Confirm?", "isekai", "Go", "Cancel"))
		spawndir = reconcile_spawndir(spawndir_choice)
	else if(quick_truck == "Yes")
		spawndir = EAST
		isekai = FALSE
		abort = "Go"
	else if(quick_truck == "Cancel")
		abort = "Cancel"


/datum/smite/isekai/effect(client/user, mob/living/target)
	if(abort == "Go")
		switch(isekai_choice)
			if("Yes")
				isekai = TRUE
			if("No")
				isekai = FALSE

		target.Stun(spawndist)

		to_chat(target, span_userdanger("LOOK OUT!"))

		send_truck(target, spawndir, spawndist, isekai)

		var/msg = "[key_name(target)] was hit by a truck spawned by [key_name(user)] that spawned [spawndist] tiles away to the [spawndir_choice]."
		message_admins(msg)
		log_admin(msg)
	else
		var/msg = "[key_name(user)] cancelled the truck before execution."
		message_admins(msg)
		log_admin(msg)


/datum/smite/isekai/proc/reconcile_spawndir(str,)
	switch(str)
		if("NORTH")
			return NORTH
		if("SOUTH")
			return SOUTH
		if("EAST")
			return EAST
		if("WEST")
			return WEST


/datum/smite/isekai/proc/send_truck(mob/living/target, spawndir, spawndist, bool = FALSE)
	var/turf/start
	var/turf/current = get_turf(target)
	for(var/i = 1 to spawndist)
		current = get_step(current, spawndir)
	start = current

	var/obj/isekai_truck/track = new /obj/isekai_truck(start)
	track.lifespan = spawndist+1
	track.truck_target = target
	track.isekai = bool
	walk(track, DIRFLIP(spawndir))
	track.setDir(DIRFLIP(spawndir))

