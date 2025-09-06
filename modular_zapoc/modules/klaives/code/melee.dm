/obj/item/melee/vampirearms/klaive
	name = "klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This blade has a blue tint, due to the way it was crafted."
	icon = 'modular_zapoc/modules/klaives/icons/weapons.dmi' //sprites by Imaginos :)
	lefthand_file = 'modular_zapoc/modules/klaives/icons/lefthand.dmi'
	righthand_file = 'modular_zapoc/modules/klaives/icons/righthand.dmi'
	onflooricon = 'modular_zapoc/modules/klaives/icons/weapons.dmi'
	hitsound = 'sound/weapons/slash.ogg'
	icon_state = "klaive"
	force = 30
	throwforce = 15
	block_chance = 5
	armour_penetration = 35
	wound_bonus = -5
	bare_wound_bonus = 5
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	w_class = WEIGHT_CLASS_NORMAL
	flags_1 = CONDUCT_1
	sharpness = SHARP_EDGED
	resistance_flags = FIRE_PROOF
	masquerade_violating = FALSE
	is_iron = FALSE
	grid_width = 2 GRID_BOXES
	grid_height = 1 GRID_BOXES
	cost = 300

/obj/item/melee/vampirearms/klaive/afterattack(atom/target, blocked = FALSE)
	. = ..()
	if(iswerewolf(target) || isgarou(target))
		var/mob/living/carbon/M = target
		if(M.auspice.gnosis)
			if(prob(50))
				adjust_gnosis(-1, M)

		M.apply_damage(20, CLONE)
		M.apply_status_effect(STATUS_EFFECT_SILVER_SLOWDOWN)

/obj/item/melee/vampirearms/klaive/karambit
	name = "curved klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one has a handle made of bone, and is curved."
	icon_state = "klaive_karambit"

/obj/item/melee/vampirearms/klaive/bane
	name = "bane klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one seems rusty, yet still quite sharp"
	icon_state = "klaive_bane"

/obj/item/melee/vampirearms/klaive/grand
	name = "grand klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one is HUGE!."
	icon = 'modular_zapoc/modules/klaives/icons/48x32weapons.dmi'
	onflooricon = 'modular_zapoc/modules/klaives/icons/48x32weapons.dmi'
	icon_state = "klaive_grand"
	force = 45
	throwforce = 10
	block_chance = 40
	armour_penetration = 30
	wound_bonus = 10
	bare_wound_bonus = 25
	w_class = WEIGHT_CLASS_HUGE
	grid_width = 2 GRID_BOXES
	grid_height = 5 GRID_BOXES

/obj/item/melee/vampirearms/klaive/grand/afterattack(atom/target, blocked = FALSE)
	. = ..()
	if(iswerewolf(target) || isgarou(target))
		var/mob/living/carbon/M = target
		if(M.auspice.gnosis)
			if(prob(50))
				adjust_gnosis(-1, M)

		M.apply_damage(30, CLONE)
		M.apply_status_effect(STATUS_EFFECT_SILVER_SLOWDOWN)

