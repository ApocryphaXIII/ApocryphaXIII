/datum/discipline/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/protean

/datum/discipline_power/protean
	name = "Protean power name"
	desc = "Protean power description"

	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/protean_deactivate.ogg'

//EYES OF THE BEAST
/datum/discipline_power/protean/eyes_of_the_beast
	name = "Eyes of the Beast"
	desc = "Let your eyes be a gateway to your Beast. Gain its eyes."

	level = 1

	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	violates_masquerade = FALSE

	toggled = TRUE
	var/original_eye_color

/datum/discipline_power/protean/eyes_of_the_beast/activate()
	. = ..()
	ADD_TRAIT(owner, TRAIT_PROTEAN_VISION, TRAIT_GENERIC)
//	owner.add_client_colour(/datum/client_colour/glass_colour/red) // APOC EDIT REMOVE - Nobody in history has ever enjoyed this.
	owner.update_sight()
	original_eye_color = owner.eye_color
	owner.eye_color = "#ff0000"
	var/obj/item/organ/eyes/organ_eyes = owner.getorganslot(ORGAN_SLOT_EYES)
	if(!organ_eyes)
		return
	else
		organ_eyes.eye_color = owner.eye_color
	owner.update_body()

/datum/discipline_power/protean/eyes_of_the_beast/deactivate()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PROTEAN_VISION, TRAIT_GENERIC)
//	owner.remove_client_colour(/datum/client_colour/glass_colour/red) // APOC EDIT REMOVE
	owner.update_sight()
	owner.eye_color = original_eye_color
	var/obj/item/organ/eyes/organ_eyes = owner.getorganslot(ORGAN_SLOT_EYES)
	if(!organ_eyes)
		return
	else
		organ_eyes.eye_color = owner.eye_color
	owner.update_body()

//FERAL CLAWS
/datum/movespeed_modifier/protean2
	multiplicative_slowdown = -0.15

/datum/discipline_power/protean/feral_claws
	name = "Feral Claws"
	desc = "Become a predator and grow hideous talons."

	level = 2

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/protean/earth_meld,
		/datum/discipline_power/protean/shape_of_the_beast,
		/datum/discipline_power/protean/mist_form
	)

/datum/discipline_power/protean/feral_claws/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.add_client_colour(/datum/client_colour/glass_colour/red)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/protean2)

/datum/discipline_power/protean/feral_claws/deactivate()
	. = ..()
	for(var/obj/item/melee/vampirearms/knife/gangrel/G in owner.contents)
		qdel(G)
	owner.remove_client_colour(/datum/client_colour/glass_colour/red)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean2)

/mob/living/simple_animal/hostile/gangrel
	name = "warform"
	desc = "A horrid man-beast abomination."
	icon = 'code/modules/wod13/32x48.dmi'
	icon_state = "gangrel_f"
	icon_living = "gangrel_f"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_HUGE
	speak_chance = 0
	speed = -0.4
	maxHealth = 275
	health = 275
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	dextrous = TRUE
	held_items = list(null, null)
	possible_a_intents = list(INTENT_HELP, INTENT_GRAB, INTENT_DISARM, INTENT_HARM)

// APOC EDIT START
/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel
	name = "Gangrel Form"
	desc = "Take on the shape a wolf."
	charge_max = 50
	cooldown_min = 5 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/gangrel

//EARTH MELD
/datum/discipline_power/protean/earth_meld
	name = "Earth Meld"
	desc = "Hide yourself in the earth itself."

	level = 3

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

	grouped_powers = list(
		/datum/discipline_power/protean/feral_claws,
		/datum/discipline_power/protean/shape_of_the_beast,
		/datum/discipline_power/protean/mist_form
	)
	var/obj/effect/decal/dirt_pile/D

/datum/discipline_power/protean/earth_meld/proc/become_soil()
	animate(owner, transform = matrix(), color = "#ffffff", time = 10) // Reset ourselves while we're invisible
	D = new (get_turf(owner)) // Spawn some dirt
	D.alpha = 64 // Subtle dirt
	owner.forceMove(D) // Put ourselves inside the dirt

/datum/discipline_power/protean/earth_meld/pre_activation_checks()
	var/allowed_turfs = list(
		/turf/open/floor/plating/vampgrass,
		/turf/open/floor/plating/vampbeach,
		/turf/open/floor/plating/vampdirt,
		/turf/open/floor/plating/rough/cave,
		/turf/open/floor/plating/stone,
		/turf/open/floor/plating/sandy_dirt, // Only used in the bank and the forest
		/turf/open/floor/plating/dirt // Only used in the nosferatu den
	) // There has to be a better way.

	if(!is_type_in_list(owner.loc, allowed_turfs)) // Check if the turf we're standing on is in allowed_turfs
		to_chat(owner,"<span class='warning'>You can't meld into the ground here!<span>")
		return FALSE
	else
		return TRUE

/datum/discipline_power/protean/earth_meld/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.Stun(20 SECONDS) // Dirt can't move, and neither can you!
	animate(owner, transform = matrix()/4, color = "#35240b", time = 10) // Sink into the earth
	addtimer(CALLBACK(src, PROC_REF(become_soil)), 1 SECONDS)

/datum/discipline_power/protean/earth_meld/deactivate()
	. = ..()
	if(owner.IsStun())
		owner.SetStun(0) // End the ongoing stun
	if(!D.expiring) // If D.expiring == 1, the following will occur anyways.
		owner.Knockdown(3 SECONDS) // Get-up lag
		owner.forceMove(get_turf(D))
		D.remove_dirt_pile()
/*
/datum/discipline_power/protean/earth_meld/activate()
	. = ..()
	if (!GA)
		GA = new(owner)
	owner.drop_all_held_items()
	GA.Shapeshift(owner)

/datum/discipline_power/protean/earth_meld/deactivate()
	. = ..()
	GA.Restore(GA.myshape)
	owner.Stun(1.5 SECONDS)
	owner.do_jitter_animation(30)
*/ // ZAPOC EDIT END

/mob/living/simple_animal/hostile/gangrel/better
	maxHealth = 325
	health = 325
	melee_damage_lower = 35
	melee_damage_upper = 35
	speed = -0.6

//SHAPE OF THE BEAST
/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel/better
	shapeshift_type = /mob/living/simple_animal/hostile/gangrel/better

/datum/discipline_power/protean/shape_of_the_beast
	name = "Shape of the Beast"
	desc = "Assume the form of an animal and retain your power."

	level = 4

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

	grouped_powers = list(
		/datum/discipline_power/protean/feral_claws,
		/datum/discipline_power/protean/earth_meld,
		/datum/discipline_power/protean/mist_form
	)

	var/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel/better/GA

/datum/discipline_power/protean/shape_of_the_beast/activate()
	. = ..()
	if (!GA)
		GA = new(owner)
	owner.drop_all_held_items()
	GA.Shapeshift(owner)

/datum/discipline_power/protean/shape_of_the_beast/deactivate()
	. = ..()
	GA.Restore(GA.myshape)
	owner.Stun(1 SECONDS)
	owner.do_jitter_animation(15)

/mob/living/simple_animal/hostile/gangrel/best
	icon_state = "gangrel_m"
	icon_living = "gangrel_m"
	maxHealth = 400 //More in line with new health values.
	health = 400
	melee_damage_lower = 40
	melee_damage_upper = 40
	speed = -0.8

//MIST FORM
/* APOC EDIT REMOVE
/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel/best
	shapeshift_type = /mob/living/simple_animal/hostile/gangrel/best
*/

/datum/discipline_power/protean/mist_form
	name = "Mist Form"
	desc = "Dissipate your body and move as mist."

	level = 5

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

	grouped_powers = list(
		/datum/discipline_power/protean/feral_claws,
		/datum/discipline_power/protean/earth_meld,
		/datum/discipline_power/protean/shape_of_the_beast
	)

	var/obj/effect/proc_holder/spell/targeted/shapeshift/mist/GA // ZAPOC EDIT CHANGE

/datum/discipline_power/protean/mist_form/activate()
	. = ..()
	if (!GA)
		GA = new(owner)
	owner.drop_all_held_items()
	GA.Shapeshift(owner)

/datum/discipline_power/protean/mist_form/deactivate()
	. = ..()
	GA.Restore(GA.myshape)
	owner.Stun(1 SECONDS)
	owner.do_jitter_animation(15)
