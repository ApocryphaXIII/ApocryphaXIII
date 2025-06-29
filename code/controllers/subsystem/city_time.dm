SUBSYSTEM_DEF(city_time)
	name = "City Time"
	init_order = INIT_ORDER_DEFAULT
	wait = 15 SECONDS
	priority = FIRE_PRIORITY_DEFAULT

	var/first_warning = FALSE
	var/second_warning = FALSE
	var/time_till_daytime = 6 HOURS
	var/daytime_started = FALSE

	var/time_till_roundend = 7 HOURS
	var/roundend_started = FALSE

	var/last_xp_drop = 0
	/// Time between xp drops in INGAME time
	var/time_between_xp_drops = 1 HOURS

/datum/controller/subsystem/city_time/fire()
	if(last_xp_drop + time_between_xp_drops < station_time_passed())
		last_xp_drop = station_time_passed()
		for(var/mob/living/carbon/werewolf/W in GLOB.player_list)
			if(W?.stat != DEAD && W?.key)
				var/datum/preferences/char_sheet = GLOB.preferences_datums[ckey(W.key)]
				char_sheet?.add_experience(2)
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H?.stat != DEAD && H?.key)
				var/datum/preferences/char_sheet = GLOB.preferences_datums[ckey(H.key)]
				if(char_sheet)
					char_sheet.add_experience(2)

					var/role = H.mind?.assigned_role

					if(role in list("Prince", "Sheriff", "Hound", "Seneschal", "Chantry Regent", "Baron", "Dealer", "Primogen Ventrue", "Primogen Lasombra", "Primogen Banu Haqim", "Primogen Nosferatu", "Primogen Malkavian", "Endron Branch Lead", "Endron Internal Affairs Agent", "Endron Executive", "Endron Chief of Security", "Painted City Councillor", "Painted City Keeper", "Painted City Warder", "Painted City Truthcatcher", "Amberlgade Councillor", "Amberglade Keeper", "Amberglade Truthcatcher", "Amberglade Warder"))
						char_sheet.add_experience(2)

					if(!HAS_TRAIT(H, TRAIT_NON_INT))
						if(H.total_erp > 3000)
							char_sheet.add_experience(3)
							H.total_erp = 0
						if(H.total_erp > 1500)
							char_sheet.add_experience(2)
							H.total_erp = 0
						if(H.total_cleaned > 25)
							char_sheet.add_experience(1)
							H.total_cleaned = 0
							call_dharma("cleangrow", H)
						if(role == "Graveyard Keeper")
							if(SSgraveyard.total_good > SSgraveyard.total_bad)
								char_sheet.add_experience(1)

					char_sheet.save_preferences()
					char_sheet.save_character()

	if(station_time_passed() > time_till_daytime - 30 MINUTES && !first_warning)
		first_warning = TRUE
		to_chat(world, "<span class='ghostalert'>The night is ending...</span>")

	if(station_time_passed() > time_till_daytime - 15 MINUTES && !second_warning)
		second_warning = TRUE
		to_chat(world, "<span class='ghostalert'>First rays of the sun illuminate the sky...</span>")

	if(station_time_passed() > time_till_daytime && !daytime_started)
		daytime_started = TRUE
		to_chat(world, "<span class='ghostalert'>THE NIGHT IS OVER.</span>")
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			var/area/vtm/V = get_area(H)
			if(!V?.upper)
				continue
			if(iskindred(H) || iscathayan(H))
				to_chat(H, span_danger("THE SUN SEARS YOUR FLESH"))
				H.take_damage(50, BURN)

	if(station_time_passed() > time_till_roundend && !roundend__started)
		roundend_started = TRUE
		SSticker.force_ending = 1
		SSticker.current_state = GAME_STATE_FINISHED
		toggle_ooc(TRUE) // Turn it on
		toggle_dooc(TRUE)
		SSticker.declare_completion(SSticker.force_ending)
		Master.SetRunLevel(RUNLEVEL_POSTGAME)
