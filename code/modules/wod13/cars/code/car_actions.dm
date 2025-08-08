
/datum/action/carr/headlight
	name = "Toggle Light"
	desc = "Toggle light on/off."
	button_icon_state = "lights"

/datum/action/carr/headlight/Trigger(trigger_flags)
	var/obj/vampire_car/car = owner.loc
	if(!istype(car))
		return
	car.set_headlight_on(!car.headlight_on)
	to_chat(owner, span_notice("You toggle [car]'s lights."))
	playsound(car, 'sound/weapons/magout.ogg', 40, TRUE)

/datum/action/carr/beep
	name = "Signal"
	desc = "Beep-beep."
	button_icon_state = "beep"

/datum/action/carr/beep/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.last_beep+10 < world.time)
			V.last_beep = world.time
			playsound(V.loc, V.beep_sound, 60, FALSE)

/datum/action/carr/stage
	name = "Toggle Transmission"
	desc = "Toggle transmission to 1, 2 or 3."
	button_icon_state = "stage"

/datum/action/carr/stage/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.stage < 3)
			V.stage = V.stage+1
		else
			V.stage = 1
		to_chat(owner, span_notice("You enable [V]'s transmission at [V.stage]."))

/datum/action/carr/baggage
	name = "Lock Baggage"
	desc = "Lock/Unlock Baggage."
	button_icon_state = "baggage"

/datum/action/carr/baggage/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		var/datum/component/storage/STR = V.GetComponent(/datum/component/storage)
		STR.locked = !STR.locked
		playsound(V, 'code/modules/wod13/sounds/door.ogg', 50, TRUE)
		if(STR.locked)
			to_chat(owner, "<span class='notice'>You lock [V]'s baggage.</span>")
		else
			to_chat(owner, "<span class='notice'>You unlock [V]'s baggage.</span>")

/datum/action/carr/engine
	name = "Toggle Engine"
	desc = "Toggle engine on/off."
	button_icon_state = "keys"

/datum/action/carr/engine/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(!V.on)
			if(V.get_integrity() == V.max_integrity)
				V.start_engine()
				playsound(V, 'code/modules/wod13/sounds/start.ogg', 50, TRUE)
				to_chat(owner, span_notice("You managed to start [V]'s engine."))
				return
			if(prob(100*(V.get_integrity()/V.max_integrity)))
				V.start_engine()
				playsound(V, 'code/modules/wod13/sounds/start.ogg', 50, TRUE)
				to_chat(owner, span_notice("You managed to start [V]'s engine."))
				return
			else
				to_chat(owner, span_warning("You failed to start [V]'s engine."))
				return
		else
			V.stop_engine()
			playsound(V, 'code/modules/wod13/sounds/stop.ogg', 50, TRUE)
			to_chat(owner, span_notice("You stop [V]'s engine."))
			V.set_light(0)
			return

/datum/action/carr/exit_car
	name = "Exit"
	desc = "Exit the vehicle."
	button_icon_state = "exit"

/datum/action/carr/exit_car/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		V.empty_occupent(owner)
