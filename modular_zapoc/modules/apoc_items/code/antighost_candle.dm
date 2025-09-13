GLOBAL_LIST_EMPTY(active_antighost_sources)

/obj/item/candle/antighost
	name = "purifying candle"
	desc = "A candle said to ward off malevolent spirits. It smells pretty bad. Are you a malevolent spirit?"
	var/radius = 1
/obj/item/candle/antighost/infinite
	infinite = TRUE
	start_lit = TRUE

/obj/item/candle/antighost/examine(mob/user)
	. = ..()
	. += span_purple("Burn a \"medicinal herb\" in the flame to intensify it's effects...")

/obj/item/candle/antighost/attackby(obj/item/W, mob/user)
	. = ..()
	if(istype(W, /obj/item/weedpack) || istype(W, /obj/item/food/vampire/weed))
		switch(radius)
			if(1)
				radius = 7
			if(7)
				radius = 15
			if(15)
				to_chat(user, "[span_warning("You try to add more of the")] [span_purple("\"medicinal herb\"")] [span_warning(" to the candle, but you cough from the amount of smoke coming off of it.")]")
				return


/obj/item/candle/antighost/light(show_message)
	. = ..()
	GLOB.active_antighost_sources += src


/obj/item/candle/antighost/extinguish()
	if(!lit)
		return
	GLOB.active_antighost_sources -= src // Remove ourselves from Da List
	. = ..()


/mob/dead/observer/avatar/proc/check_antighost_candle(NewLoc)
	var/list/nearest_candle_distances = list(INFINITY)
	var/nearest_candle_dist
	var/nearest_candle

	for(var/i in GLOB.active_antighost_sources) // get all active antighosts
		var/current_dist = get_dist(i, src)
		if(current_dist == min(nearest_candle_distances))
				nearest_candle = i

	nearest_candle_dist = get_dist(nearest_candle, src)

	if(!aghosted && (nearest_candle_dist <= 15))
		antighost_kickout(nearest_candle_dist, nearest_candle)
		if(COOLDOWN_FINISHED(src, move_error_debounce))
			to_chat(src, span_warning("A purifying smoke prevents you from advancing."))
			COOLDOWN_START(src, move_error_debounce, 1 SECONDS)
		return TRUE
	else
		return FALSE

/mob/dead/observer/avatar/proc/antighost_kickout(distance, obj/item/candle/antighost/agc)
	var/kickout = 3 SECONDS
	if(distance <= agc.radius) // If we're in the radius of the candle
		kickout -= 1 SECONDS
		if(kickout > 0)
			addtimer(CALLBACK(src, PROC_REF(antighost_kickout), distance, agc), 1 SECONDS) // Are we still here?
		else
			finalize_reenter_corpse() // Gotta blast
