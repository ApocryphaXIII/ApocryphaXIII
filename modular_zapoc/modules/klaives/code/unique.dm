/obj/item/melee/vampirearms/klaive/grand/skyrend
	name = "Skyrend"
	desc = "An enormous silver sword that doesn't look happy to see you. Your hair stands up on the back of your neck, and the air crackles with ionization."

/obj/item/melee/vampirearms/klaive/grand/skyrend/afterattack(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		shock(L, 0.5 SECONDS)
		L.apply_damage(10, BURN)

	if(iscarbon(loc))
		var/mob/living/carbon/C = loc
		if(isliving(target))
			C.apply_damage(20, STAMINA)
			if(C.getStaminaLoss() >= 90)
				to_chat(C, span_userdanger("The spirits wrack your body with exhaustion... you might collapse any second!"))

/obj/item/melee/vampirearms/klaive/grand/skyrend/proc/shock(mob/living/target, stun_time)
	var/datum/effect_system/lightning_spread/s = new /datum/effect_system/lightning_spread
	s.set_up(5, 1, target.loc)
	s.start()

	target.visible_message("<span class='danger'>[target.name] is shocked by [src]!</span>", \
		"<span class='userdanger'>You feel a powerful shock course through you!</span>", \
		"<span class='hear'>You hear a heavy electrical crack!</span>")
	return

/obj/item/melee/vampirearms/klaive/grand/skyrend/examine(mob/user)
	. = ..()
	. += span_purple("Imbued with spirits of war, lightning, and fire. Together, they are <b>Skyrend</b>.")
