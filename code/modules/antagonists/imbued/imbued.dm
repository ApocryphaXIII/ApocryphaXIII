#warn replace genetic_points with xp

// https://hackmd.io/@bPZ2CWi4RqCwevLwDEezBQ/rJ4h-4lzgl
// Like some other old "antags" these arent really hostile or activly antagonistic.
// But the code structure/utility provided by the datum lets us overlook this
/datum/antagonist/imbued
	name = "Imbued"

	var/creed
	var/virtues = list(
		VIRTUE_ZEAL = 0,
		VIRTUE_MECRY = 0,
		VIRTUE_VISION = 0
	)

	/// The number of conviction points (to buy edges) this imbued currently has.
	var/conviction = 10
	/// The max number of conviction points (to buy edges) this imbued can have..
	var/total_conviction = 10

	/// Whether we can currently respec in the edge menu. Likely admin only.
	var/can_respec = 0

	/// A reference to our imbued menu datum.
	var/datum/imbued_menu/imbued_menu
	/// A reference to our imbued menu action (which opens the UI for the datum).
	var/datum/action/imbued_edge_menu/edge_menu_action

	/// List of all powers we start with.
	var/list/innate_powers = list()
	/// Associated list of all powers we have evolved / bought from the emporium. [path] = [instance of path]
	var/list/purchased_powers = list()
	/// Static typecache of all imbued powers that are usable.
	var/static/list/all_powers = typecacheof(/datum/action/imbued_edge, ignore_root_path = TRUE)

/datum/antagonist/imbued/Destroy()
	QDEL_NULL(edge_menu_action)
	QDEL_NULL(imbued_menu)
	return ..()

/datum/antagonist/imbued/on_gain()
	create_imbued_menu()
	create_innate_actions()
	return ..()

/datum/antagonist/imbued/apply_innate_effects(mob/living/mob_override)
	var/mob/mob_to_tweak = mob_override || owner.current
	if(!isliving(mob_to_tweak))
		return

	var/mob/living/living_mob = mob_to_tweak
	RegisterSignal(living_mob, COMSIG_MOB_LOGIN, PROC_REF(on_login))
	RegisterSignal(living_mob, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_item))

/datum/antagonist/imbued/remove_innate_effects(mob/living/mob_override)
	var/mob/living/living_mob = mob_override || owner.current
	UnregisterSignal(living_mob, list(COMSIG_MOB_LOGIN, COMSIG_MOB_GET_STATUS_TAB_ITEMS))

/datum/antagonist/imbued/on_removal()
	remove_imbued_powers(include_innate = TRUE)
	return ..()

/datum/antagonist/imbued/farewell()
	#warn update message
	to_chat(owner.current, span_userdanger("You grow weak and lose your powers! You are no longer a imbued and are stuck in your current form!"))

/*
 * Instantiate the cellular emporium for the imbued.
 */
/datum/antagonist/imbued/proc/create_imbued_menu()
	imbued_menu = new(src)
	edge_menu_action = new(imbued_menu)
	edge_menu_action.Grant(owner.current)

/*
 * Instantiate all the default actions of a ling (transform, dna sting, absorb, etc)
 * Any Imbued action with edge_dots = IMBUED_POWER_INNATE will be added here automatically
 */
/datum/antagonist/imbued/proc/create_innate_actions()
	for(var/datum/action/imbued_edge/path as anything in all_powers)
		if(initial(path.edge_dots) != IMBUED_POWER_INNATE)
			continue

		var/datum/action/imbued_edge/innate_ability = new path()
		innate_powers += innate_ability
		innate_ability.on_purchase(owner.current, TRUE)

/*
 * Signal proc for [COMSIG_MOB_LOGIN].
 * Gives us back our action buttons if we lose them on log-in.
 */
/datum/antagonist/imbued/proc/on_login(datum/source)
	SIGNAL_HANDLER

	if(!isliving(source))
		return
	var/mob/living/living_source = source
	if(!living_source.mind)
		return

	regain_powers()

/datum/antagonist/imbued/proc/get_status_tab_item(mob/living/source, list/items)
	SIGNAL_HANDLER
	items += "Conviction: [conviction]/[total_conviction]"

#warn refactor to make sure it saves this
/*
 * Adjust the chem charges of the ling by [amount]
 * and clamp it between 0 and override_cap (if supplied) or total_chem_storage (if no override supplied)
 */
/datum/antagonist/imbued/proc/adjust_conviction(amount, override_cap)
	if(!isnum(amount))
		return
	conviction = clamp(conviction + amount, 0, total_conviction)

/*
 * Remove imbued powers from the current Imbued's purchased_powers list.
 *
 * if [include_innate] = TRUE, will also remove all powers from the Imbued's innate_powers list.
 */
/datum/antagonist/imbued/proc/remove_imbued_powers(include_innate = FALSE)
	if(!isliving(owner.current))
		return

	QDEL_LIST_ASSOC_VAL(purchased_powers)
	if(include_innate)
		QDEL_LIST(innate_powers)

/*
 * For resetting all of the imbued's action buttons. (IE, re-granting them all.)
 */
/datum/antagonist/imbued/proc/regain_powers()
	edge_menu_action.Grant(owner.current)
	for(var/datum/action/imbued_edge/power as anything in innate_powers)
		power.on_purchase(owner.current)

	for(var/power_path in purchased_powers)
		var/datum/action/imbued_edge/power = purchased_powers[power_path]
		if(istype(power))
			power.on_purchase(owner.current)

/*
 * The act of purchasing a certain power for a imbued.
 *
 * [edge_path] - the power that's being purchased / evolved.
 */
/datum/antagonist/imbued/proc/purchase_power(datum/action/imbued_edge/edge_path)
	if(!ispath(edge_path, /datum/action/imbued_edge))
		CRASH("Imbued purchase_power attempted to purchase an invalid typepath! (got: [edge_path])")

	if(purchased_powers[edge_path])
		to_chat(owner.current, span_warning("You have this edge!"))
		return FALSE

	#warn refactor to xp
	/*
	if(genetic_points < initial(edge_path.edge_dots))
		to_chat(owner.current, span_warning("We have reached our capacity for abilities!"))
		return FALSE
	*/

	if(initial(edge_path.edge_dots) < 0)
		to_chat(owner.current, span_warning("You cannot choose this edge!"))
		return FALSE

	var/matching_creed = 0
	for(var/datum/action/imbued_edge/purchased_edge in purchased_powers)
		if(purchased_edge.related_creed == edge_path.related_creed)
			matching_creed++

	if(matching_creed >= EDGES_PER_CREED)
		to_chat(owner.current, span_warning("You can only have [EDGES_PER_CREED] edges per creed!"))
		return FALSE

	var/success = give_power(edge_path)
	#warn refactor
	/*
	if(success)
		genetic_points -= initial(edge_path.edge_dots)
	*/
	return success

/**
 * Gives a passed imbued power datum to the player
 *
 * Is passed a path to a imbued power, and applies it to the user.
 * If successful, we return TRUE, otherwise not.
 *
 * Arguments:
 * * power_path - The path of the power we will be giving to our attached player.
 */

/datum/antagonist/imbued/proc/give_power(power_path)
	var/datum/action/imbued_edge/new_action = new power_path()

	if(!new_action)
		to_chat(owner.current, "This is awkward. Imbued power purchase failed, please report this bug to a coder!")
		CRASH("Imbued give_power was unable to grant a new imbued action for path [power_path]!")

	purchased_powers[power_path] = new_action
	new_action.on_purchase(owner.current) // Grant() is ran in this proc, see imbued_powers.dm.
	//log_imbued_power("[key_name(owner)] adapted the [new_action.name] power")
	SSblackbox.record_feedback("tally", "imbued_power_purchase", 1, new_action.name)

	return TRUE

/*
 * Imbued's ability to re-adapt all of their learned powers.
 */
/datum/antagonist/imbued/proc/readapt()
	if(!can_respec)
		//to_chat(owner.current, span_warning("You lack the power to readapt your evolutions!"))
		return FALSE

	//to_chat(owner.current, span_notice("We have removed our evolutions from this form, and are now ready to readapt."))
	remove_imbued_powers()
	can_respec -= 1
	SSblackbox.record_feedback("tally", "imbued_power_purchase", 1, "Readapt")
	//log_imbued_power("[key_name(owner)] readapted their imbued powers")
	return TRUE

#warn TODO: Move
/obj/structure/chisel_message/the_word

/obj/structure/chisel_message/the_word/Initialize(mapload)
	. = ..()
	var/image/I = image(icon = 'icons/effects/effects.dmi', icon_state = "blessed", layer = ABOVE_OPEN_TURF_LAYER, loc = src)
	I.alpha = 255
	I.appearance_flags = RESET_ALPHA
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/the_word, "blessing", I)

/proc/creed_to_virtue(creed)
	var/static/indexed_by_creed = list(
			CREED_DEFENDER = VIRTUE_ZEAL,
			CREED_JUDGE = VIRTUE_ZEAL,
			CREED_AVENGER = VIRTUE_ZEAL,
			CREED_MARTYR = VIRTUE_MERCY,
			CREED_INNOCENT = VIRTUE_MERCY,
			CREED_REDEEMER = VIRTUE_MERCY,
			CREED_VISIONARY = VIRTUE_VISION,
			CREED_HERMIT = VIRTUE_VISION,
			CREED_WAYWARD = VIRTUE_VISION
		)
	return indexed_by_creed[creed]
