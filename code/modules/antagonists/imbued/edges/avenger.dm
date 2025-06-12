/datum/action/imbued_edge/weapon/cleave
	name = "cleave"
	edge_dots = IMBUED_POWER_INNATE //1
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
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)

/datum/action/imbued_edge/impact

/datum/action/imbued_edge/trail

/datum/action/imbued_edge/smoulder

/datum/action/imbued_edge/firewalk

/datum/action/imbued_edge/surge

/datum/action/imbued_edge/smite
