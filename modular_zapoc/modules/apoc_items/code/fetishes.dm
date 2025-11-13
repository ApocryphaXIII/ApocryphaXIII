/* Spawner */
/obj/effect/spawner/random/occult/fetish
	name = "random garou fetish"
	spawn_loot_chance = 50
	loot = list(
		/obj/item/vtm_artifact/nyxs_bangle,
		/obj/item/vtm_artifact/dagger_of_retribution
	)


/* Nyx's Bangle */
/obj/item/vtm_artifact/nyxs_bangle
	name = "silver bracelet"
	desc = "A chain bracelet made of silver."
	true_name = "Nyx's Bangle"
	true_desc = "A silver bracelet with numerous glyphs."
	icon = 'modular_zapoc/modules/apoc_items/icons/fetishes.dmi'
	worn_icon = 'modular_zapoc/modules/apoc_items/icons/fetishes_worn.dmi'
	lefthand_file = 'modular_zapoc/modules/apoc_items/icons/fetishes_lefthand.dmi'
	righthand_file = 'modular_zapoc/modules/apoc_items/icons/fetishes_righthand.dmi'
	icon_state = "bangle"
	worn_icon_state = "bangle"
	slot_flags = ITEM_SLOT_GLOVES | ITEM_SLOT_ID
	ONFLOOR_ICON_HELPER('modular_zapoc/modules/apoc_items/icons/fetishes_onfloor.dmi')
	subsystem_type = /datum/controller/subsystem/processing/fastprocess
	var/spirit_name = "Glitchimus"
	var/spirit_type = "ahelp"

/obj/item/vtm_artifact/nyxs_bangle/identificate()
	. = ..()
	say("I am [spirit_name]... Hide now, in shadow.")


/obj/item/vtm_artifact/nyxs_bangle/remove_powers()
	..()
	var/mob/living/carbon/human/H = owner
	animate(owner, H.alpha = 255, time = 1.5 SECONDS, loop = 0)


/obj/item/vtm_artifact/nyxs_bangle/process(delta_time)
	. = ..()
	if(identified && iscarbon(owner))
		var/turf/T = get_turf(owner)
		var/light_amount = T.get_lumcount()

		if(light_amount <= 0.2)
			var/mob/living/carbon/C = owner
			if(!src == C.gloves && !src == C.wear_id && !src == C.get_active_held_item() && !src == C.get_inactive_held_item())
				return
			else
				animate(owner, alpha = 36, time = 1.5 SECONDS, loop = 0)
		else
			animate(owner, alpha = 255, time = 1.5 SECONDS, loop = 0, flags = ANIMATION_SLICE)


/obj/item/vtm_artifact/nyxs_bangle/Initialize(mapload)
	. = ..()
	spirit_type = pick(SPIRIT_NIGHT, SPIRIT_DARKNESS)
	spirit_name = generate_spirit_name(spirit_type)


/obj/item/vtm_artifact/nyxs_bangle/examine(mob/user)
	. = ..()
	if(identified)
		. += span_nicegreen("Hide everything but your bestial eyes in shadow.")
		. += span_notice("<b>EQUIP</b> [src] in the <b>ID</b> slot or <b>GLOVES</b> slot or <b>HOLD</b> it in your hand to become partially invisible in shadow.")
		. += span_purple("Imbued with [spirit_name].")


/* Dagger of Retribution */
/obj/item/vtm_artifact/dagger_of_retribution
	name = "iron knife"
	desc = "A crude knife wrought from iron."
	true_name = "dagger of retribution"
	true_desc = "An ugly iron dagger imbued with a vengeance-spirit."
	icon = 'modular_zapoc/modules/apoc_items/icons/fetishes.dmi'
	lefthand_file = 'modular_zapoc/modules/apoc_items/icons/fetishes_lefthand.dmi'
	righthand_file = 'modular_zapoc/modules/apoc_items/icons/fetishes_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_zapoc/modules/apoc_items/icons/fetishes_onfloor.dmi')
	icon_state = "dagger"
	force = 30
	wound_bonus = -5
	bare_wound_bonus = 5
	throwforce = 15
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/weapons/slash.ogg'
	armour_penetration = 35
	block_chance = 5
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	is_iron = TRUE
	is_wood = TRUE
	subsystem_type = /datum/controller/subsystem/processing/fastprocess

	var/spirit_name = "Glitchimus"
	var/spirit_type = "ahelp"

	var/obj/bound_item

	var/spinning


/obj/item/vtm_artifact/dagger_of_retribution/Initialize(mapload)
	. = ..()
	spirit_type = SPIRIT_VENGEANCE
	spirit_name = generate_spirit_name(spirit_type)


/obj/item/vtm_artifact/dagger_of_retribution/identificate()
	. = ..()
	say("I am [spirit_name]... That which is lost will be found...")

/obj/item/vtm_artifact/dagger_of_retribution/examine(mob/user)
	. = ..()
	if(identified)
		. += span_nicegreen("Concentrate on a lost item while holding the dagger; the weapon will gently tug in the direction of the item until you reclaim it.")
		. += span_notice("Bind an item by <b>CLICK</b>ing on it with [src] while on <b><span color='yellow'>GRAB</span></b> intent.")
		. += span_purple("Imbued with [spirit_name].")
		if(bound_item)
			. += span_purple("Bound to [bound_item].")
			if(iscarbon(loc))
				var/mob/living/carbon/C = loc

				var/obj/item/mainhand = C.get_active_held_item()
				var/obj/item/offhand = C.get_inactive_held_item()

				if(mainhand == src || offhand == src)
					. += span_notice("It's tugging you to the [angle2text(angle_between_points(get_turf(src), get_turf(bound_item)))]")


/obj/item/vtm_artifact/dagger_of_retribution/pickup(mob/user)
	. = ..()
	if(bound_item)
		start_live_tracking(user)


/obj/item/vtm_artifact/dagger_of_retribution/dropped(mob/M)
	. = ..()
	if(bound_item)
		stop_live_tracking(M)


/obj/item/vtm_artifact/dagger_of_retribution/pre_attack(atom/target, mob/living/user)
	. = ..()
	if(identified && !bound_item)
		if(istype(target, /obj) && user.a_intent == INTENT_GRAB)
			bound_item = target
			start_live_tracking(user)
			return TRUE
		else
			to_chat(user, span_warning("[src] is already bound to [bound_item]!"))
		return FALSE


/obj/item/vtm_artifact/dagger_of_retribution/Destroy()
	stop_live_tracking()
	bound_item = null
	return ..()


/obj/item/vtm_artifact/dagger_of_retribution/proc/start_live_tracking(mob/user)
	RegisterSignal(bound_item, COMSIG_QDELETING, PROC_REF(stop_live_tracking))

	if(bound_item)
		if(user)
			to_chat(user, span_notice("[src] starts tugging you towards [bound_item]."))

		START_PROCESSING(SSfastprocess, src)


/obj/item/vtm_artifact/dagger_of_retribution/proc/stop_live_tracking(mob/user)
	UnregisterSignal(bound_item, COMSIG_QDELETING)

	if(QDELING(bound_item))
		bound_item = null

	if(user)
		to_chat(user, span_warning("[src] stops tugging."))

	var/matrix/M = matrix(0, MATRIX_ROTATE)
	animate(src, transform = M, time = 5, loop = 0)

	STOP_PROCESSING(SSfastprocess, src)


/obj/item/vtm_artifact/dagger_of_retribution/process()
	var/turf/T = get_turf(src)

	if(T.z == bound_item.z)
		point_to_target()
		spinning = 0
	else if(!spinning)
		SpinAnimation(5, -1)
		spinning = 1


/obj/item/vtm_artifact/dagger_of_retribution/proc/point_to_target()
	if(iscarbon(loc))
		var/mob/living/carbon/C = loc

		var/obj/item/mainhand = C.get_active_held_item()
		var/obj/item/offhand = C.get_inactive_held_item()

		if(mainhand == src || offhand == src)
			var/bound_dir = angle_between_points(get_turf(src), get_turf(bound_item))-135
			if(bound_item)
				var/matrix/M = matrix(bound_dir, MATRIX_ROTATE)
				animate(src, transform = M, time = 5, loop = 0)
			else
				stop_live_tracking(C)


/obj/item/vtm_artifact/dagger_of_retribution/AltClick(mob/user)
	. = ..()
	if(bound_item)
		to_chat(user, span_warning("You start to unbind [bound_item] from [src]."))

		if(do_after(user, 3 SECONDS, src))
			stop_live_tracking(user)
			bound_item = null
