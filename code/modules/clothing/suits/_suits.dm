/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	slot_flags = ITEM_SLOT_OCLOTHING
	var/blood_overlay_type = "suit"
	var/togglename = null
	var/suittoggled = FALSE
	limb_integrity = 0 // disabled for most exo-suits
	allowed = list(/obj/item/flashlight, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/ammo_box/magazine, /obj/item/p25radio, /obj/item/vamp/keys, /obj/item/melee/vampirearms/knife, /obj/item/gun/ballistic/vampire/revolver/snub, /obj/item/gun/ballistic/automatic/vampire/glock19, /obj/item/gun/ballistic/automatic/vampire/m1911, /obj/item/ammo_box/vampire/c9mm/moonclip, /obj/item/vamp/phone, /obj/item/book, /obj/item/storage/book, /obj/item/vampirebook, /obj/item/clothing/gloves, /obj/item/clothing/neck, /obj/item/clothing/glasses, /obj/item/reagent_containers/blood, /obj/item/vampire_stake, /obj/item/storage/wallet, /obj/item/stack/dollar/rand, /obj/item/card/credit, /obj/item/masquerade_contract, /obj/item/melee/classic_baton/vampire)


/obj/item/clothing/suit/worn_overlays(isinhands = FALSE)
	. = list()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damaged[blood_overlay_type]")
		if(HAS_BLOOD_DNA(src))
			. += mutable_appearance('icons/effects/blood.dmi', "[blood_overlay_type]blood")
		var/mob/living/carbon/human/M = loc
		if(ishuman(M) && M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			if(istype(U) && U.attached_accessory)
				var/obj/item/clothing/accessory/A = U.attached_accessory
				if(A.above_suit)
					. += U.accessory_overlay

/obj/item/clothing/suit/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_suit()
