/obj/item/soapstone
	name = "soapstone"
	desc = "Leave informative messages for the city, including the souls of future nights!\nEven if out of uses, it can still be used to remove messages.\n(Not suitable for engraving on shuttles, off station or on cats. Side effects may include prompt beatings, psychotic clown incursions, and/or orbital bombardment.)"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "soapstone"
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/tool_speed = 50
	var/remaining_uses = 3
	var/chisel_type = /obj/structure/chisel_message

/obj/item/soapstone/Initialize(mapload)
	. = ..()
	check_name()

/obj/item/soapstone/examine(mob/user)
	. = ..()
	if(remaining_uses != -1)
		. += "It has [remaining_uses] uses left."

/obj/item/soapstone/afterattack(atom/target, mob/user, proximity, params)
	. = ..()
	var/turf/T = get_turf(target)
	if(!proximity)
		return

	var/obj/structure/chisel_message/existing_message
	if(istype(target, /obj/structure/chisel_message))
		existing_message = target

	if(!remaining_uses && !existing_message)
		to_chat(user, "<span class='warning'>[src] is too worn out to use.</span>")
		return

	if(!good_chisel_message_location(T))
		to_chat(user, "<span class='warning'>It's not appropriate to engrave on [T].</span>")
		return

	if(existing_message)
		user.visible_message("<span class='notice'>[user] starts erasing [existing_message].</span>", "<span class='notice'>You start erasing [existing_message].</span>", "<span class='hear'>You hear a chipping sound.</span>")
		if(do_after(user, tool_speed, target = existing_message))
			user.visible_message("<span class='notice'>[user] erases [existing_message].</span>", "<span class='notice'>You erase [existing_message][existing_message.creator_key == user.ckey ? ", refunding a use" : ""].</span>")
			existing_message.persists = FALSE
			qdel(existing_message)
			if(existing_message.creator_key == user.ckey)
				refund_use()
		return

	// APOC ADD START - IMBUED
	var/list/click_params = params2list(params)
	var/clickx
	var/clicky

	if(click_params && click_params["icon-x"] && click_params["icon-y"])
		clickx = clamp(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
		clicky = clamp(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)
	// APOC ADD END - IMBUED

	var/message = get_message(user)
	if(!message)
		to_chat(user, "<span class='notice'>You decide not to engrave anything.</span>")
		return

	// APOC REMOVAL START - IMBUED
	/*
	if(!target.Adjacent(user) && locate(/obj/structure/chisel_message) in T)
		to_chat(user, "<span class='warning'>Someone wrote here before you chose! Find another spot.</span>")
		return
	*/
	// APOC REMOVAL END - IMBUED
	user.visible_message("<span class='notice'>[user] starts engraving a message into [T]...</span>", "<span class='notice'>You start engraving a message into [T]...</span>", "<span class='hear'>You hear a chipping sound.</span>")
	if(can_use() && do_after(user, tool_speed, target = T) && can_use()) //This looks messy but it's actually really clever!
		user.visible_message("<span class='notice'>[user] leaves a message for future spacemen!</span>", "<span class='notice'>You engrave a message into [T]!</span>", "<span class='hear'>You hear a chipping sound.</span>")
		var/obj/structure/chisel_message/M = new chisel_type(T)
		M.register(user, message)
		// APOC ADD START - IMBUED
		M.pixel_x = clickx
		M.pixel_y = clicky
		// APOC END START - IMBUED
		remove_use()

/obj/item/soapstone/proc/get_message(mob/user)
	return stripped_input(user, "What would you like to engrave?", "Leave a message")

/obj/item/soapstone/proc/can_use()
	return remaining_uses == -1 || remaining_uses >= 0

/obj/item/soapstone/proc/remove_use()
	if(remaining_uses <= 0)
		return
	remaining_uses--
	check_name()

/obj/item/soapstone/proc/refund_use()
	if(remaining_uses == -1)
		return
	remaining_uses++
	check_name()

/obj/item/soapstone/proc/check_name()
	if(remaining_uses)
		// This will mess up RPG loot names, but w/e
		name = initial(name)
	else
		name = "dull [initial(name)]"

/* Persistent engraved messages, etched onto the station turfs to serve
as instructions and/or memes for the next generation of spessmen.

Limited in location to station_z only. Can be smashed out or exploded,
but only permanently removed with the curator's soapstone.
*/

/obj/item/soapstone/infinite
	remaining_uses = -1

/obj/item/soapstone/empty
	remaining_uses = 0

/proc/good_chisel_message_location(turf/T)
	if(!T)
		. = FALSE
	else if(!(isfloorturf(T) || iswallturf(T)))
		. = FALSE
	else
		. = TRUE

/obj/structure/chisel_message
	name = "engraved message"
	desc = "A message from a past traveler."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "soapstone_message"
	layer = LATTICE_LAYER
	density = FALSE
	anchored = TRUE
	max_integrity = 30

	var/hidden_message
	var/creator_key
	var/creator_name
	var/realdate
	var/map
	var/persists = TRUE
	var/list/like_keys = list()
	var/list/dislike_keys = list()

	var/turf/original_turf

	var/the_word = FALSE

	/// Total vote count at or below which we won't persist.
	var/delete_at = -5

/obj/structure/chisel_message/Initialize(mapload)
	. = ..()
	SSpersistence.chisel_messages += src
	var/turf/T = get_turf(src)
	original_turf = T

	if(!good_chisel_message_location(T))
		persists = FALSE
		return INITIALIZE_HINT_QDEL

	if(like_keys.len - dislike_keys.len <= delete_at)
		persists = FALSE

/obj/structure/chisel_message/proc/register(mob/user, newmessage)
	hidden_message = newmessage
	creator_name = user.real_name
	creator_key = user.ckey
	realdate = world.realtime
	map = SSmapping.config.map_name
	update_appearance()

/obj/structure/chisel_message/update_appearance()
	. = ..()
	update_message_apperance()

/obj/structure/chisel_message/proc/update_message_apperance()
	var/hash = md5(hidden_message)
	var/newcolor = copytext_char(hash, 1, 7)
	add_atom_colour("#[newcolor]", FIXED_COLOUR_PRIORITY)
	set_light_color("#[newcolor]")
	set_light(1)

/obj/structure/chisel_message/proc/pack()
	var/list/data = list()
	data["hidden_message"] = hidden_message
	data["creator_name"] = creator_name
	data["creator_key"] = creator_key
	data["realdate"] = realdate
	data["map"] = SSmapping.config.map_name
	data["x"] = original_turf.x
	data["y"] = original_turf.y
	data["z"] = original_turf.z
	// APOC ADD START - IMBUED
	data["pixel_x"] = pixel_x
	data["pixel_y"] = pixel_y
	// APOC ADD END - IMBUED
	data["like_keys"] = like_keys
	data["dislike_keys"] = dislike_keys
	data["the_word"] = the_word
	return data

/obj/structure/chisel_message/proc/unpack(list/data)
	if(!islist(data))
		return

	hidden_message = data["hidden_message"]
	creator_name = data["creator_name"]
	creator_key = data["creator_key"]
	realdate = data["realdate"]
	like_keys = data["like_keys"]
	if(!like_keys)
		like_keys = list()
	dislike_keys = data["dislike_keys"]
	if(!dislike_keys)
		dislike_keys = list()

	// APOC ADD START - IMBUED
	if(data["pixel_x"] && data["pixel_y"])
		pixel_x = data["pixel_x"]
		pixel_y = data["pixel_y"]
	// APOC ADD END - IMBUED
	var/x = data["x"]
	var/y = data["y"]
	var/z = data["z"]
	var/turf/newloc = locate(x, y, z)
	if(isturf(newloc))
		forceMove(newloc)
	update_appearance()

/obj/structure/chisel_message/examine(mob/user)
	. = ..()
	if(can_read_message(user))
		ui_interact(user)
	else
		to_chat(user, span_warning("I cant make out what this says"))

/obj/structure/chisel_message/proc/can_read_message(mob/user)
	return user.can_read(src)

/obj/structure/chisel_message/Destroy()
	if(persists)
		SSpersistence.SaveChiselMessage(src)
	SSpersistence.chisel_messages -= src
	. = ..()

/obj/structure/chisel_message/interact()
	return

/obj/structure/chisel_message/ui_state(mob/user)
	return GLOB.always_state

/obj/structure/chisel_message/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EngravedMessage", name)
		ui.open()

/obj/structure/chisel_message/ui_data(mob/user)
	var/list/data = list()

	data["hidden_message"] = hidden_message
	data["realdate"] = SQLtime(realdate)
	data["num_likes"] = like_keys.len
	data["num_dislikes"] = dislike_keys.len
	data["is_creator"] = user.ckey == creator_key
	data["has_liked"] = (user.ckey in like_keys)
	data["has_disliked"] = (user.ckey in dislike_keys)

	if(check_rights_for(user.client, R_ADMIN))
		data["admin_mode"] = TRUE
		data["creator_key"] = creator_key
		data["creator_name"] = creator_name

	return data

/obj/structure/chisel_message/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	var/mob/user = usr
	var/is_admin = check_rights_for(user.client, R_ADMIN)
	var/is_creator = user.ckey == creator_key
	var/has_liked = (user.ckey in like_keys)
	var/has_disliked = (user.ckey in dislike_keys)

	switch(action)
		if("like")
			if(is_creator)
				return
			if(has_disliked)
				dislike_keys -= user.ckey
			like_keys |= user.ckey
			. = TRUE
		if("dislike")
			if(is_creator)
				return
			if(has_liked)
				like_keys -= user.ckey
			dislike_keys |= user.ckey
			. = TRUE
		if("neutral")
			if(is_creator)
				return
			dislike_keys -= user.ckey
			like_keys -= user.ckey
			. = TRUE
		if("delete")
			if(!is_admin)
				return
			var/confirm = alert(user, "Confirm deletion of engraved message?", "Confirm Deletion", "Yes", "No")
			if(confirm == "Yes")
				persists = FALSE
				qdel(src)
				return

	persists = like_keys.len - dislike_keys.len > delete_at
