/mob/dead/observer/avatar/
	var/returning = FALSE // Are we recalling right now?
	sound_environment_override = SOUND_ENVIRONMENT_DRUGGED

/obj/vampire_car/handle_caring() // This SUUUUUCKS.
	var/mob/dead/observer/avatar/AA
	if(passengers.len || !isnull(driver))
		if(AA.mind.current in passengers || AA.mind.current == driver) // Is our host in a running/moving car?
			if(speed_in_pixels)
				AA.finalize_reenter_corpse()

	. = ..()


/mob/dead/observer/avatar/Move(NewLoc)
	if(check_antighost_candle(NewLoc)) // APOC EDIT ADD START // Prevents ghosts from hanging out near smudge sticks
		return // APOC EDIT ADD END
	var/mob/living/carbon/human/H = mind.current
	if(get_dist(NewLoc, get_turf(H)) > 22) // How are we so far away?
		to_chat(src, span_warning("Your connection to your physical form weakens, forcing to recenter yourself."))
		finalize_reenter_corpse()
		return FALSE

	if(get_dist(NewLoc, get_turf(H)) == 22) // Skip movement if we're too far
		to_chat(src, span_warning("Your connection to your physical form weakens, preventing you from moving any further!"))
		return FALSE

	if(get_dist(NewLoc, get_turf(H)) >= 18) // Danger zone.
		if(prob(5))
			auspex_deafness(src)

	..()

	var/dist_mod = get_dist(loc, H.loc)

//	to_chat(src, span_cult("[dist_mod]"))

	overlay_fullscreen("auspex_block", /atom/movable/screen/fullscreen/auspex, 1) // Don't change severity unless you want to make a new icon for the fullscreen!
	var/atom/movable/screen/fullscreen/S = screens["auspex_block"]

	if(dist_mod == 21) // 255 / 21 = 12.1428671429. Yeah, this is probably better.
		S.alpha = 255
	else
		S.alpha = round(dist_mod*12)

	if(prob(1)) // || src.loc.area.protected == TRUE) // This is for later and probably won't be implemented this way
		espionage_check(src, H)

	if(get_turf(src) == get_turf(mind.current.loc) && returning) // Stop moving and reenter corpse if we're on top of ourselves. No effect unless reenter_corpse() is running.
		walk(src, 0)
		finalize_reenter_corpse()
		returning = FALSE

/mob/dead/observer/avatar/proc/auspex_deafness(mob/dead/user)
	if(HAS_TRAIT(src, TRAIT_DEAF)) // Are we already deaf?
		REMOVE_TRAIT(src, TRAIT_DEAF, "auspex_avatar")
		to_chat(src, span_notice("Your psyche refocuses, your senses returning to you."))
	else // We aren't. Add deafness.
		SEND_SOUND(user, sound('sound/weapons/flash_ring.ogg'))
		to_chat(src, span_warning("Your psyche shudders, restricting your senses."))
		ADD_TRAIT(src, TRAIT_DEAF, "auspex_avatar")
		addtimer(CALLBACK(src, PROC_REF(auspex_deafness), user), 3 SECONDS)



/mob/dead/observer/avatar/proc/espionage_check(mob/dead/observer/user, mob/living/carbon/body)
	var/peepers = view(7, user) // List of things we can see
	var/peepers_mobs = list()

	for(var/mob/living/carbon/C in peepers) // Populare peepers_mobs
		if(!(C == user))
			peepers_mobs += C // Jeepers!

	var/peepers_len = LAZYLEN(peepers_mobs) // How many?

	to_chat(user, span_warning("Your concentration lapses..."))
	var/roll_result = SSroll.storyteller_roll(body.get_total_mentality(), difficulty = peepers_len, mobs_to_show_output = user) // Roll for initiative

	if(roll_result == ROLL_SUCCESS)
		to_chat(user, span_notice("...but you manage to regain your focus.")) // Phew...
		return TRUE
	else
		for(var/mob/living/carbon/_C in peepers_mobs) // Anyone hear that?
			if(!(ishumanbasic(_C))) // Normal humans can't hear ghosts
				if(SSroll.storyteller_roll(_C.get_total_mentality(), difficulty = (body.get_total_mentality()), mobs_to_show_output = null) == ROLL_SUCCESS) // Are we smart enough to hear the peeping tom?
					SEND_SOUND(user, sound('modular_zapoc/modules/apoc_disciplines/sound/avatar_cancel.ogg', 0, 0, 10))
		to_chat(user, span_boldwarning("...revealing your presence!"))


/mob/dead/observer/avatar/proc/finalize_reenter_corpse() // Seperated for ease of use
	var/mob/living/carbon/human/original_body = mind.current

	client.view_size.setDefault(getScreenSize(client.prefs.widescreenpref))
	SStgui.on_transfer(src, mind.current)
	mind.current.key = key
	mind.current.client.init_verbs()
	original_body.soul_state = SOUL_PRESENT
	returning = FALSE


/mob/dead/observer/avatar/reenter_corpse()
	if(!client)
		return FALSE
	if(!mind || QDELETED(mind.current))
		to_chat(src, span_warning("You have no body."))
		return FALSE
	if(!can_reenter_corpse)
		to_chat(src, span_warning("You cannot re-enter your body."))
		return FALSE

	var/mob/living/carbon/human/original_body = mind.current
	var/turf/current_turf = get_turf(src)
	var/turf/body_turf = get_turf(original_body)

	if(isnull(body_turf) || isnull(current_turf))
		return FALSE
	if(returning) // First line in this proc that is different than the auspex_avatar.dm version
		walk(src, 0) // Cancel recall
		to_chat(src, span_warning("You force your mind's eye to dig in it's psychic heels, cancelling the recall."))
		returning = FALSE
		return FALSE
	if(mind.current.key && mind.current.key[1] != "@")	// makes sure we don't accidentally kick any clients
		to_chat(usr, span_warning("Another consciousness is in your body...It is resisting you."))
		return FALSE
	if(!(body_turf.z == current_turf.z))
		to_chat(src, span_warning("Your physical form is on a different level of reality."))
		return FALSE
	if(!(body_turf == current_turf))
		returning = TRUE
		walk_to(src, body_turf, 0) // Start recall
		to_chat(src, span_warning("Your physical form begins to recall your mind's eye..."))
		to_chat(src, span_notice("Click Reenter corpse again to cancel."))
		SEND_SOUND(src, 'modular_zapoc/modules/apoc_disciplines/sound/avatar_cancel.ogg')
		return FALSE
	else
		finalize_reenter_corpse()

	return TRUE
