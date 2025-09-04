/obj/item/clothing/glasses/apoc/eyepatch
	name = "eyepatch"
	desc = "Put this over your eye if you don't want your eye to see, or if you don't want to see your eye."
	icon = 'modular_zapoc/modules/clothing/icons/eyepatches.dmi'
	worn_icon = 'modular_zapoc/modules/clothing/icons/eyepatches_worn.dmi'
	icon_state = "eyepatch"
	base_icon_state = "eyepatch"
	inhand_icon_state = "eyepatch"
	custom_materials = list(/datum/material/glass = 250)
	var/wornunder = TRUE
	var/flipped = FALSE


/obj/item/clothing/glasses/apoc/eyepatch/attack_self(mob/user)
	wornunder = !wornunder
	alternate_worn_layer = wornunder ? GLASSES_LAYER : UPPER_EARS_LAYER
	to_chat(user, span_notice("You adjust the [src]."))


/obj/item/clothing/glasses/apoc/eyepatch/proc/on_examine(datum/source, mob/user, list/examine_list)
	examine_list += "Alt-click to flip the eyepatch to the other eye."


/obj/item/clothing/glasses/apoc/eyepatch/AltClick(mob/user)
	if(isliving(user))
		swap_eye(user)


/obj/item/clothing/glasses/apoc/eyepatch/proc/swap_eye(mob/user)
	flipped = !flipped
	icon_state = flipped ? "[base_icon_state]_flipped" : base_icon_state
	if (!ismob(user))
		return
	var/mob/living/carbon/human/H = user
	H.regenerate_icons()


/obj/item/clothing/glasses/apoc/eyepatch/medical
	name = "medical eyepatch"
	desc = "Used by weeaboos to pretend their eye isn't there, and those who actually lost their eye to pretend their eye is there."
	icon_state = "eyepatch_medical"
	base_icon_state = "eyepatch_medical"
	inhand_icon_state = null


/obj/item/clothing/glasses/apoc/blindfold
	name = "blindfold"
	desc = "Fold it over your eyes to go blind."
	icon = 'modular_zapoc/modules/clothing/icons/eyepatches.dmi'
	worn_icon = 'modular_zapoc/modules/clothing/icons/eyepatches_worn.dmi'
	icon_state = "blindfoldwhite"
	base_icon_state = "blindfoldwhite"
	worn_icon_state = "blindfoldwhite_both"
	var/wornunder = TRUE
	var/trick = FALSE
	var/adjusted_state = "both"
	var/oldname = "blindfold"


/obj/item/clothing/glasses/apoc/blindfold/trick
	desc = "Fold it over your eyes to not go blind, because this one is too thin to obstruct your vision. Cheater."
	trick = TRUE


/obj/item/clothing/glasses/apoc/blindfold/attack_self(mob/user)
	wornunder = !wornunder
	alternate_worn_layer = wornunder ? GLASSES_LAYER : UPPER_EARS_LAYER
	to_chat(user, span_notice("You adjust the [src]."))


/obj/item/clothing/glasses/apoc/blindfold/proc/on_examine(datum/source, mob/user, list/examine_list)
	examine_list += span_notice("Alt-click to adjust the [name]. Use in hand to change layer.")


/obj/item/clothing/glasses/apoc/blindfold/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if((slot == ITEM_SLOT_EYES && !trick) && adjusted_state == "both")
		user.become_blind("blindfold_[REF(src)]")


/obj/item/clothing/glasses/apoc/blindfold/dropped(mob/living/carbon/human/user)
	..()
	user.cure_blind("blindfold_[REF(src)]")


/obj/item/clothing/glasses/apoc/blindfold/AltClick(mob/user)
	if(!ishuman(user))
		return
	adjust_blindfold(user)


/obj/item/clothing/glasses/apoc/blindfold/proc/adjust_blindfold(mob/living/carbon/user)

	switch(adjusted_state)
		if("both")
			adjusted_state = "left"
			name = "eyepatch"
			desc = "A fabric eyepatch over your left eye."
			oldname = "blindfold"
			user.cure_blind("blindfold_[REF(src)]")
		if("left")
			adjusted_state = "right"
			desc = "A fabric eyepatch over your right eye."
		if("right")
			adjusted_state = "head"
			name = "headband"
			desc = "A tied fabric headband."
			oldname = "eyepatch"
		if("head")
			name = "blindfold"
			adjusted_state = "both"
			desc = initial(desc)
			oldname = "headband"
			if((user.glasses == src && !trick) && adjusted_state == "both")
				user.become_blind("blindfold_[REF(src)]")

	worn_icon_state = "[base_icon_state]_[adjusted_state]"

	to_chat(user, span_notice("You adjust the [oldname], wearing it as [name]."))

	user.update_inv_glasses()
