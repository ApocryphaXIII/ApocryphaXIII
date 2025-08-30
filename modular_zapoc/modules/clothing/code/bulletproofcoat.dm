/obj/item/clothing/suit/vampire
	var/can_have_armor = TRUE
	var/mutable_appearance/vest_underlay


/obj/item/clothing/suit/vampire/Initialize(mapload)
	. = ..()
	if(can_have_armor)
		AddComponent(/datum/component/armor_plate, _maxamount = 1, _upgrade_item = /obj/item/clothing/suit/vampire/vest, _added_armor = list(MELEE = 55, BULLET = 55, LASER = 10, ENERGY = 10, BOMB = 55, BIO = 0, RAD = 0, FIRE = 45, ACID = 10, WOUND = 25), set_armor = TRUE)
		RegisterSignal(src, COMSIG_ARMOR_PLATED, PROC_REF(upgrade_icon))


/obj/item/clothing/suit/vampire/worn_overlays(isinhands = FALSE)
	. = ..()
	if(vest_underlay && !isinhands)
		vest_underlay.icon = worn_icon
		vest_underlay.layer = UNDER_SUIT_LAYER
		. += vest_underlay


/obj/item/clothing/suit/vampire/proc/upgrade_icon(datum/source, amount, maxamount)
	SIGNAL_HANDLER

	var/datum/component/armor_plate/component_ref = GetComponent(/datum/component/armor_plate)
	var/obj/item/clothing/suit/vampire/vest/vest_type = component_ref.upgrade_item_used
	var/vest_icon = vest_type::icon_state

	if(amount)
		name = "armored [initial(name)]"
		worn_icon_state = vest_icon
		desc = "[initial(desc)] Has a durable, lightweight vest. Slay."
		vest_underlay = mutable_appearance(worn_icon, "[initial(icon_state)]")
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			C.regenerate_icons()
