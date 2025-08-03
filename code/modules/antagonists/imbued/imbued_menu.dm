/datum/imbued_menu
	var/datum/antagonist/imbued/imbued

/datum/imbued_menu/New(my_imbued)
	. = ..()
	imbued = my_imbued

/datum/imbued_menu/Destroy()
	imbued = null
	return ..()

/datum/imbued_menu/ui_state(mob/user)
	return GLOB.always_state

/datum/imbued_menu/ui_status(mob/user, datum/ui_state/state)
	if(!imbued)
		return UI_CLOSE
	return UI_INTERACTIVE

/datum/imbued_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ImbuedMenu", "imbued edge menu")
		ui.open()

/datum/imbued_menu/ui_static_data(mob/user)
	var/list/data = list()

	var/static/list/abilities
	if(isnull(abilities))
		abilities = list()
		for(var/datum/action/imbued_edge/ability_path as anything in imbued.all_powers)

			var/dna_cost = initial(ability_path.edge_dots)

			if(dna_cost < 0) // 0 = free, but negatives are invalid
				continue

			var/list/ability_data = list()
			ability_data["name"] = initial(ability_path.name)
			ability_data["desc"] = initial(ability_path.desc)
			ability_data["path"] = ability_path
			ability_data["helptext"] = initial(ability_path.helptext)
			ability_data["genetic_point_required"] = dna_cost
			//ability_data["absorbs_required"] = initial(ability_path.req_absorbs) // compares against imbued true_absorbs
			//ability_data["dna_required"] = initial(ability_path.req_dna) // compares against imbued absorbed_count

			abilities += list(ability_data)

		// Sorts abilities alphabetically by default
		//sortTim(abilities, /proc/cmp_assoc_list_name)

	data["abilities"] = abilities
	return data

/datum/imbued_menu/ui_data(mob/user)
	var/list/data = list()

	data["can_readapt"] = imbued.can_respec
	//data["owned_abilities"] = assoc_to_keys(imbued.purchased_powers)
	data["xp"] = imbued?.owner?.current?:client?:prefs?:player_experience
	//data["absorb_count"] = imbued.true_absorbs
	//data["dna_count"] = imbued.absorbed_count

	return data

/datum/imbued_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("readapt")
			if(imbued.can_respec)
				imbued.readapt()

		if("evolve")
			// purchase_power sanity checks stuff like typepath, DNA, and absorbs for us.
			imbued.purchase_power(text2path(params["path"]))

	return TRUE

/datum/action/imbued_edge_menu
	name = "Imbued Edge Menu"
	check_flags = NONE

/datum/action/imbued_edge_menu/New(Target)
	. = ..()
	if(!istype(Target, /datum/imbued_menu))
		stack_trace("imbued_menu action created with no menu.")
		qdel(src)

/datum/action/imbued_edge_menu/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	target.ui_interact(owner)
