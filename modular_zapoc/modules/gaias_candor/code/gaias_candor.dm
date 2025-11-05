/obj/item/melee/touch_attack/truth_of_gaia
	name = "Gaia's Candor"
	desc = "This Gift allows the Garou to determine if her quarry speaks the truth."
	catchphrase = null
	icon = 'modular_zapoc/modules/gaias_candor/icons/gaias_candor.dmi'
	icon_state = "gaias_candor"


/obj/item/melee/touch_attack/truth_of_gaia/proc/call_input(mob/living/target, mob/living/user)
	var/mob/living/L = target

	SEND_SOUND(L, sound('sound/magic/clockwork/invoke_general.ogg', 0, 0, 50)) // LOOK OUT! A WEREWOLF IS SMELLING YOU!

	var/response_w = input(L, "Does your character believe your last statement is the truth?") in list("Yes", "No", "Not sure", "Refuse to answer")

	if(response_w == "Yes") // Telling the truth!
		to_chat(user, "<span class='notice'>[L]'s scent bares the aroma of truthfulness.</span>")
	else if(response_w == "No") // Lying!
		to_chat(user, "<span class='notice'>[L]'s scent bares the aroma of deceit.</span>")
	else // Dunno
		to_chat(user, "<span class='notice'>[L]'s scent is uncertain. You can't determine the truth one way or the other.</span>")

	return


/obj/item/melee/touch_attack/truth_of_gaia/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(isliving(target)) // Turfs can't tell the truth.
		var/mob/living/L = target

		if(!L.client) // NPCs can't tell the truth
			to_chat(user, span_notice("[L]'s scent is uncertain. You can't determine the truth one way or the other."))
			return ..()

		if(L == user) // Are we smelling ourselves?
			to_chat(user, span_notice("You smell yourself. Your scent bares the aroma of inquiry."))
			return ..()

		if(!ishumanbasic(target)) // Impossible to know if a human knows of the Garou, so we'll assume humans are powerless to resist.
			var/theirpower = SSroll.storyteller_roll(L.get_total_mentality(), difficulty = 0, mobs_to_show_output = null, numerical = TRUE)
			var/mypower = SSroll.storyteller_roll(user.get_total_social(), difficulty = theirpower, mobs_to_show_output = user, numerical = TRUE)

			if(mypower > theirpower) // Test of wills
				call_input(L, user)
				to_chat(user, span_warning("[L]'s scent is uncertain. You can't determine the truth one way or the other."))
				qdel(src)
			return ..()


/datum/action/gift/truth_of_gaia
	name = "Gaia's Candor"
	desc = "Determine if someone believes their answer is the truth based on scent."
	button_icon_state = "truth_of_gaia"


/datum/action/gift/truth_of_gaia/Trigger()
	. = ..()

	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner

		H.visible_message(span_notice("[H] inhales deeply."), \
		span_notice("You inhale deeply."))
		SEND_SOUND(H, sound('modular_zapoc/modules/gaias_candor/sound/truth_of_gaia.ogg', 0, 0, 75))
		H.put_in_active_hand(new /obj/item/melee/touch_attack/truth_of_gaia(H))
