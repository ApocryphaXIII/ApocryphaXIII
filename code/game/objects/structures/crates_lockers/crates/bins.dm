/obj/structure/closet/crate/bin
	desc = "A trash bin, place your trash here for the janitor to collect."
	name = "trash bin"
	icon_state = "largebins"
	open_sound = 'sound/effects/bin_open.ogg'
	close_sound = 'sound/effects/bin_close.ogg'
	anchored = TRUE
	horizontal = FALSE
	delivery_icon = null

/obj/structure/closet/crate/bin/Initialize()
	. = ..()
	update_appearance()

/obj/structure/closet/crate/bin/update_overlays()
	. = ..()
	if(contents.len == 0)
		. += "largebing"
		return
	if(contents.len >= storage_capacity)
		. += "largebinr"
		return
	. += "largebino"

/obj/structure/closet/crate/bin/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/storage/bag/trash))
		var/obj/item/storage/bag/trash/T = W
		to_chat(user, "<span class='notice'>You fill the bag.</span>")
		for(var/obj/item/O in src)
			SEND_SIGNAL(T, COMSIG_TRY_STORAGE_INSERT, O, user, TRUE)
		T.update_appearance()
		do_animate()
		return TRUE
	else
		return ..()

/obj/structure/closet/crate/bin/proc/do_animate()
	playsound(loc, open_sound, 15, TRUE, -3)
	flick("animate_largebins", src)
	addtimer(CALLBACK(src, PROC_REF(do_close)), 13)

/obj/structure/closet/crate/bin/proc/do_close()
	playsound(loc, close_sound, 15, TRUE, -3)
	update_appearance()

//I should make these slow to move
/obj/structure/closet/crate/dumpster
	name = "dumpster"
	desc = "Holds garbage inside."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "garbage"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	var/internal_trash_chance = 75
	var/external_trash_chance = 10

/obj/structure/closet/crate/dumpster/Initialize()
	if(prob(25))
		icon_state = "garbageopen"
	. = ..()
	//Letting you clear the snow by opening and closing it is acctually pretty flavor
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/closet/crate/dumpster/PopulateContents()
	if(prob(internal_trash_chance))
		if(prob(95))
			new /obj/effect/spawner/random/trash/garbage(src)
		else //Pretty rare while the loot table is un-audited
			new /obj/effect/spawner/random/maintenance/random(src)
	if(prob(external_trash_chance))
		new /obj/effect/spawner/random/trash/grime(loc)

/obj/structure/closet/crate/dumpster/empty
	internal_trash_chance = 0
	external_trash_chance = 0

