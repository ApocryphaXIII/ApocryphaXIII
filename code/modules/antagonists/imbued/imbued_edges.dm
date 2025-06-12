// Heavily based off the modern TG /datum/action/imbued, i might have left 1 or 2 refrences in here.
/datum/action/imbued_edge
	/// Details displayed in fine print within the changling emporium
	var/helptext = ""
	/// Makes it cheaper to buy this edge
	var/related_virture
	/// Equivelent to dna_cost from imbued
	var/xp_cost = 0
	var/conviction_cost = 0
	/// Maximum stat before the ability is blocked.
	/// For example, `UNCONSCIOUS` prevents it from being used when in hard crit or dead,
	/// while `DEAD` allows the ability to be used on any stat values.
	var/req_stat = CONSCIOUS
	/// usable when the changel
	/// used by a few powers that toggle
	var/active = FALSE

/*
imbued code now relies on on_purchase to grant powers.
if you override it, MAKE SURE you call parent or it will not be usable
the same goes for Remove(). if you override Remove(), call parent or else your power won't be removed on respec
*/

/datum/action/imbued_edge/proc/on_purchase(mob/user, is_respec)
	Grant(user)//how powers are added rather than the checks in mob.dm

/*
/datum/action/imbued_edge/IsAvailable()
	. = ..()
	var/datum/antagonist/imbued/imbued = IS_IMBUED(owner)
	if(!imbued || (imbued.conviction < conviction_cost))
		return FALSE
*/

/datum/action/imbued_edge/Trigger(trigger_flags)
	var/mob/user = owner
	if(!user || !IS_IMBUED(user))
		return
	try_edge(user)


/**
 *This handles the activation of the action and the deducation of its cost.
 *The order of the proc chain is:
 *can_use_edge(). Should this fail, the process gets aborted early.
 *edge_action(). This proc usually handles the actual effect of the action.
 *Should edge_action succeed the following will be done:
 *usage_feedback(). Produces feedback on the performed action. Don't ask me why this isn't handled in edge_action()
 *The deduction of the cost of this power.
 *Returns TRUE on a successful activation.
 */
/datum/action/imbued_edge/proc/try_edge(mob/living/user, mob/living/target)
	if(!can_use_edge(user, target))
		return FALSE
	var/datum/antagonist/imbued/imbued = IS_IMBUED(user)
	if(edge_action(user, target))
		usage_feedback(user, target)
		imbued.adjust_con(-conviction_cost)
		user.changeNext_move(CLICK_CD_MELEE)
		return TRUE
	return FALSE

/datum/action/imbued_edge/proc/edge_action(mob/living/user, mob/living/target)
	SHOULD_CALL_PARENT(TRUE)
	SSblackbox.record_feedback("nested tally", "edge_used", 1, list("[name]"))
	return FALSE

/datum/action/imbued_edge/proc/usage_feedback(mob/living/user, mob/living/target)
	return FALSE

// Fairly important to remember to return 1 on success >.< // Return TRUE not 1 >.<
/datum/action/imbued_edge/proc/can_use_edge(mob/living/user, mob/living/target)
	var/datum/antagonist/imbued/imbued = IS_IMBUED(user)
	if(imbued.conviction < conviction_cost)
		user.balloon_alert(user, "needs [conviction_cost] conviction!")
		return FALSE
	if(req_stat < user.stat)
		user.balloon_alert(user, "incapacitated!")
		return FALSE
	return TRUE
