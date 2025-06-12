#define VITURE_ZEAL "zeal"
#define VITURE_MERCY "mercy"
#define VITURE_VISION "vision"

#define MAX_DOT_TOTAL 15
#define MAX_DOT_PER_VIRTUE 10

#warn replace genetic_points with xp

// https://hackmd.io/@bPZ2CWi4RqCwevLwDEezBQ/rJ4h-4lzgl
// Like some other old "antags" these arent really hostile or activly antagonistic.
// But the code structure/utility provided by the datum lets us overlook this
/datum/antagonist/imbued
	name = "Imbued"

	/// The number of conviction points (to buy edges) this imbued currently has.
	var/conviction = 10
	/// The max number of conviction points (to buy edges) this imbued can have..
	var/total_conviction = 10

	/// A reference to our imbued menu datum.
	var/datum/imbued_menu/imbued_menu
	/// A reference to our imbued menu action (which opens the UI for the datum).
	var/datum/action/imbued_edge_menu/edge_menu_action

	/// List of all powers we start with.
	var/list/innate_powers = list()
	/// Associated list of all powers we have evolved / bought from the emporium. [path] = [instance of path]
	var/list/purchased_powers = list()
	/// Static typecache of all changeling powers that are usable.
	var/static/list/all_powers = typecacheof(/datum/action/imbued_edge, ignore_root_path = TRUE)

/datum/antagonist/imbued/Destroy()
	QDEL_NULL(edge_menu_action)
	QDEL_NULL(imbued_menu)
	current_profile = null
	return ..()

/datum/antagonist/imbued/on_gain()
	create_emporium()
	create_innate_actions()
	return ..()

/datum/antagonist/imbued/apply_innate_effects(mob/living/mob_override)
	var/mob/mob_to_tweak = mob_override || owner.current
	if(!isliving(mob_to_tweak))
		return

	var/mob/living/living_mob = mob_to_tweak
	handle_clown_mutation(living_mob, "You have evolved beyond your clownish nature, allowing you to wield weapons without harming yourself.")
	RegisterSignal(living_mob, COMSIG_MOB_LOGIN, PROC_REF(on_login))
	RegisterSignal(living_mob, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	RegisterSignal(living_mob, COMSIG_LIVING_POST_FULLY_HEAL, PROC_REF(on_fullhealed))
	RegisterSignal(living_mob, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_item))
	RegisterSignals(living_mob, list(COMSIG_MOB_MIDDLECLICKON, COMSIG_MOB_ALTCLICKON), PROC_REF(on_click_sting))
	ADD_TRAIT(living_mob, TRAIT_FAKE_SOULLESS, IMBUED_TRAIT)

	if(living_mob.hud_used)
		var/datum/hud/hud_used = living_mob.hud_used

		lingchemdisplay = new /atom/movable/screen/ling/chems(null, hud_used)
		hud_used.infodisplay += lingchemdisplay

		lingstingdisplay = new /atom/movable/screen/ling/sting(null, hud_used)
		hud_used.infodisplay += lingstingdisplay

		hud_used.show_hud(hud_used.hud_version)
	else
		RegisterSignal(living_mob, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))

	make_brain_decoy(living_mob)

/datum/antagonist/imbued/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER

	var/datum/hud/ling_hud = owner.current.hud_used

	lingchemdisplay = new(null, ling_hud)
	ling_hud.infodisplay += lingchemdisplay

	lingstingdisplay = new(null, ling_hud)
	ling_hud.infodisplay += lingstingdisplay

	ling_hud.show_hud(ling_hud.hud_version)

/datum/antagonist/imbued/remove_innate_effects(mob/living/mob_override)
	var/mob/living/living_mob = mob_override || owner.current
	handle_clown_mutation(living_mob, removing = FALSE)
	UnregisterSignal(living_mob, list(COMSIG_MOB_LOGIN, COMSIG_LIVING_LIFE, COMSIG_LIVING_POST_FULLY_HEAL, COMSIG_MOB_GET_STATUS_TAB_ITEMS, COMSIG_MOB_MIDDLECLICKON, COMSIG_MOB_ALTCLICKON))
	REMOVE_TRAIT(living_mob, TRAIT_FAKE_SOULLESS, IMBUED_TRAIT)

	if(living_mob.hud_used)
		var/datum/hud/hud_used = living_mob.hud_used

		hud_used.infodisplay -= lingchemdisplay
		hud_used.infodisplay -= lingstingdisplay
		QDEL_NULL(lingchemdisplay)
		QDEL_NULL(lingstingdisplay)

	// The old body's brain still remains a decoy, I guess?

/datum/antagonist/imbued/on_removal()
	remove_changeling_powers(include_innate = TRUE)
	return ..()

/datum/antagonist/imbued/farewell()
	to_chat(owner.current, span_userdanger("You grow weak and lose your powers! You are no longer a changeling and are stuck in your current form!"))

/*
 * Instantiate the cellular emporium for the changeling.
 */
/datum/antagonist/imbued/proc/create_emporium()
	imbued_menu = new(src)
	edge_menu_action = new(imbued_menu)
	edge_menu_action.Grant(owner.current)

/*
 * Instantiate all the default actions of a ling (transform, dna sting, absorb, etc)
 * Any Changeling action with xp_cost = IMBUED_POWER_INNATE will be added here automatically
 */
/datum/antagonist/imbued/proc/create_innate_actions()
	for(var/datum/action/imbued_edge/path as anything in all_powers)
		if(initial(path.xp_cost) != IMBUED_POWER_INNATE)
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

/**
 * Signal proc for [COMSIG_MOB_MIDDLECLICKON] and [COMSIG_MOB_ALTCLICKON].
 * Allows the changeling to sting people with a click.
 */
/datum/antagonist/imbued/proc/on_click_sting(mob/living/ling, atom/clicked)
	SIGNAL_HANDLER

	// nothing to handle
	if(!chosen_sting)
		return
	if(!isliving(ling) || clicked == ling || ling.stat != CONSCIOUS)
		return
	// sort-of hack done here: we use in_given_range here because it's quicker.
	// actual ling stings do pathfinding to determine whether the target's "in range".
	// however, this is "close enough" preliminary checks to not block click
	if(!isliving(clicked) || !IN_GIVEN_RANGE(ling, clicked, sting_range))
		return

	INVOKE_ASYNC(chosen_sting, TYPE_PROC_REF(/datum/action/imbued_edge/sting, try_to_sting), ling, clicked)

	return COMSIG_MOB_CANCEL_CLICKON

/datum/antagonist/imbued/proc/get_status_tab_item(mob/living/source, list/items)
	SIGNAL_HANDLER
	items += "Chemical Storage: [chem_charges]/[total_chem_storage]"
	items += "Absorbed DNA: [absorbed_count]"

/*
 * Adjust the chem charges of the ling by [amount]
 * and clamp it between 0 and override_cap (if supplied) or total_chem_storage (if no override supplied)
 */
/datum/antagonist/imbued/proc/adjust_chemicals(amount, override_cap)
	if(!isnum(amount))
		return
	var/cap_to = isnum(override_cap) ? override_cap : total_chem_storage
	chem_charges = clamp(chem_charges + amount, 0, cap_to)

	lingchemdisplay?.maptext = FORMAT_CHEM_CHARGES_TEXT(chem_charges)

/*
 * Remove changeling powers from the current Changeling's purchased_powers list.
 *
 * if [include_innate] = TRUE, will also remove all powers from the Changeling's innate_powers list.
 */
/datum/antagonist/imbued/proc/remove_changeling_powers(include_innate = FALSE)
	if(!isliving(owner.current))
		return

	if(chosen_sting)
		chosen_sting.unset_sting(owner.current)

	QDEL_LIST_ASSOC_VAL(purchased_powers)
	if(include_innate)
		QDEL_LIST(innate_powers)

	genetic_points = total_genetic_points
	chem_charges = min(chem_charges, total_chem_storage)
	chem_recharge_rate = initial(chem_recharge_rate)
	chem_recharge_slowdown = initial(chem_recharge_slowdown)

/*
 * For resetting all of the changeling's action buttons. (IE, re-granting them all.)
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
 * The act of purchasing a certain power for a changeling.
 *
 * [edge_path] - the power that's being purchased / evolved.
 */
/datum/antagonist/imbued/proc/purchase_power(datum/action/imbued_edge/edge_path)
	if(!ispath(edge_path, /datum/action/imbued_edge))
		CRASH("Changeling purchase_power attempted to purchase an invalid typepath! (got: [edge_path])")

	if(purchased_powers[edge_path])
		to_chat(owner.current, span_warning("We have already evolved this ability!"))
		return FALSE

	if(genetic_points < initial(edge_path.xp_cost))
		to_chat(owner.current, span_warning("We have reached our capacity for abilities!"))
		return FALSE

	if(initial(edge_path.xp_cost) < 0)
		to_chat(owner.current, span_warning("We cannot evolve this ability!"))
		return FALSE

	var/success = give_power(edge_path)
	if(success)
		genetic_points -= initial(edge_path.xp_cost)
	return success

/**
 * Gives a passed changeling power datum to the player
 *
 * Is passed a path to a changeling power, and applies it to the user.
 * If successful, we return TRUE, otherwise not.
 *
 * Arguments:
 * * power_path - The path of the power we will be giving to our attached player.
 */

/datum/antagonist/imbued/proc/give_power(power_path)
	var/datum/action/imbued_edge/new_action = new power_path()

	if(!new_action)
		to_chat(owner.current, "This is awkward. Changeling power purchase failed, please report this bug to a coder!")
		CRASH("Changeling give_power was unable to grant a new changeling action for path [power_path]!")

	purchased_powers[power_path] = new_action
	new_action.on_purchase(owner.current) // Grant() is ran in this proc, see changeling_powers.dm.
	log_changeling_power("[key_name(owner)] adapted the [new_action.name] power")
	SSblackbox.record_feedback("tally", "changeling_power_purchase", 1, new_action.name)

	return TRUE

/*
 * Changeling's ability to re-adapt all of their learned powers.
 */
/datum/antagonist/imbued/proc/readapt()
	if(!ishuman(owner.current) || ismonkey(owner.current))
		to_chat(owner.current, span_warning("We can't remove our evolutions in this form!"))
		return FALSE

	if(HAS_TRAIT_FROM(owner.current, TRAIT_DEATHCOMA, IMBUED_TRAIT))
		to_chat(owner.current, span_warning("We are too busy reforming ourselves to readapt right now!"))
		return FALSE

	if(!can_respec)
		to_chat(owner.current, span_warning("You lack the power to readapt your evolutions!"))
		return FALSE

	to_chat(owner.current, span_notice("We have removed our evolutions from this form, and are now ready to readapt."))
	remove_changeling_powers()
	can_respec -= 1
	SSblackbox.record_feedback("tally", "changeling_power_purchase", 1, "Readapt")
	log_changeling_power("[key_name(owner)] readapted their changeling powers")
	return TRUE

#warn TODO: Move
/obj/structure/chisel_message/the_word

/obj/structure/chisel_message/the_word/Initialize(mapload)
	. = ..()
	var/image/I = image(icon = 'icons/effects/effects.dmi', icon_state = "blessed", layer = ABOVE_OPEN_TURF_LAYER, loc = src)
	I.alpha = 170
	I.appearance_flags = RESET_ALPHA
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/the_word, "blessing", I)
