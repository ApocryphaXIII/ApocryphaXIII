/obj/item/clothing/suit
	var/can_have_armor = FALSE
	var/is_armored = FALSE
	var/mutable_appearance/vest_underlay


/obj/item/clothing/suit/Initialize(mapload)
	. = ..()
	if(can_have_armor)
		AddComponent(/datum/component/armor_plate, _maxamount = 1, _upgrade_item = /obj/item/clothing/suit/vampire/vest, _added_armor = list(MELEE = 55, BULLET = 55, LASER = 10, ENERGY = 10, BOMB = 55, BIO = 0, RAD = 0, FIRE = 45, ACID = 10, WOUND = 25))
		RegisterSignal(src, COMSIG_ARMOR_PLATED, PROC_REF(upgrade_icon_vest))


/obj/item/clothing/suit/worn_overlays(isinhands = FALSE)
	. = ..()
	if(vest_underlay && !isinhands)
		// if(worn_icon)
		vest_underlay.icon = initial(worn_icon) || 'icons/mob/clothing/suit.dmi'
		// else
		// 	vest_underlay.icon = 'icons/mob/clothing/suit.dmi'

		. += vest_underlay


/obj/item/clothing/suit/proc/upgrade_icon_vest(datum/source, amount, maxamount)
	SIGNAL_HANDLER

	var/datum/component/armor_plate/component_ref = GetComponent(/datum/component/armor_plate)
	var/obj/item/clothing/suit/vampire/vest/vest_type = component_ref.upgrade_item_used
	var/vest_worn_icon = vest_type::worn_icon
	var/vest_icon_state = vest_type::icon_state

	if(amount)
		name = "armored [initial(name)]"
		worn_icon = vest_worn_icon
		worn_icon_state = vest_icon_state
		desc = "[initial(desc)] Has a durable, lightweight vest. Slay. Alt-click to seperate the vest from [src]."
		vest_underlay = mutable_appearance(worn_icon || 'icons/mob/clothing/suit.dmi', "[initial(icon_state)]")
		is_armored = TRUE
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			C.regenerate_icons()

/obj/item/clothing/suit/AltClick(mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/living_mob = user
		if(!(living_mob.mobility_flags & MOBILITY_PICKUP))
			return

	if(is_armored == TRUE)
		var/datum/component/armor_plate/component_ref = GetComponent(/datum/component/armor_plate)
		var/obj/item/clothing/suit/vampire/vest/vest_type_used = component_ref.upgrade_item_used
		var/obj/item/clothing/suit/vampire/vest/new_vest = new vest_type_used.type
		user.put_in_hands(new_vest)
		is_armored = FALSE
		name = initial(name)
		desc = initial(desc)
		vest_underlay = null
		worn_icon = initial(worn_icon)
		worn_icon_state = initial(worn_icon_state)
		armor.detachArmor(vest_type_used.armor)
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			C.regenerate_icons()
		qdel(component_ref)
		AddComponent(/datum/component/armor_plate, _maxamount = 1, _upgrade_item = /obj/item/clothing/suit/vampire/vest, _added_armor = list(MELEE = 55, BULLET = 55, LASER = 10, ENERGY = 10, BOMB = 55, BIO = 0, RAD = 0, FIRE = 45, ACID = 10, WOUND = 25))

