/datum/action/imbued_edge/weapon/cleave
	name = "Cleave"
	related_creed = CREED_AVENGER
	edge_dots = 1
	weapon_type = /obj/item/melee/imbued_cleave

#warn cleanup
/obj/item/melee/imbued_cleave
	name = "hardlight blade"
	desc = "An extremely sharp blade made out of hard light. Packs quite a punch."
	icon = 'icons/obj/transforming_energy.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "lightblade"
	inhand_icon_state = "lightblade"
	//hitsound_on = 'sound/weapons/blade1.ogg'
	heat = 3500
	item_flags = ABSTRACT | DROPDEL

/obj/item/melee/imbued_cleave/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, IMBUED_TRAIT)

/datum/action/imbued_edge/impact
	name = "Impact"
	related_creed = CREED_AVENGER
	edge_dots = 1

/datum/action/imbued_edge/trail
	name = "Trail"
	related_creed = CREED_AVENGER
	edge_dots = 2

/datum/action/imbued_edge/smoulder
	name = "Smoulder"
	related_creed = CREED_AVENGER
	edge_dots = 3

/datum/action/imbued_edge/firewalk
	name = "Firewalk"
	related_creed = CREED_AVENGER
	edge_dots = 4

/datum/action/imbued_edge/surge
	name = "Surge"
	related_creed = CREED_AVENGER
	edge_dots = 4

/datum/action/imbued_edge/smite
	name = "Smite"
	related_creed = CREED_AVENGER
	edge_dots = 5
