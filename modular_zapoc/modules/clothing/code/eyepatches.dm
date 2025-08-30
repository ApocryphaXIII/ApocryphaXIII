/obj/item/clothing/glasses/apoc/eyepatch
	name = "eyepatch"
	desc = "Put this over your eye if you don't want your eye to see, or if you don't want to see your eye."
	icon = 'modular_zapoc/modules/clothing/icons/eyepatches.dmi'
	worn_icon = 'modular_zapoc/modules/clothing/icons/eyepatches_worn.dmi'
	icon_state = "eyepatch"
	base_icon_state = "eyepatch"
	inhand_icon_state = "eyepatch"
	custom_materials = list(/datum/material/glass = 250)
	var/flipped = FALSE


/obj/item/clothing/glasses/apoc/eyepatch/proc/on_examine(datum/source, mob/user, list/examine_list)
	examine_list += "Alt-click to flip the eyepatch to the other eye."


/obj/item/clothing/glasses/apoc/eyepatch/AltClick()
	swap_eye(src)


/obj/item/clothing/glasses/apoc/eyepatch/proc/swap_eye()
	flipped = !flipped
	icon_state = flipped ? "[base_icon_state]_flipped" : base_icon_state
	if (!ismob(loc))
		return
	var/mob/user = loc
	user.update_inv_glasses()


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
	inhand_icon_state = "blindfoldwhite"
	var/trick = FALSE
	var/adjusted_state = "both"

/obj/item/clothing/glasses/apoc/blindfold/proc/on_examine(datum/source, mob/user, list/examine_list)
	examine_list += "Alt-click to adjust the [name]."


/obj/item/clothing/glasses/apoc/blindfold/trick
	desc = "Fold it over your eyes to not go blind, because this one is too thin to obstruct your vision. Cheater."
	icon_state = "blindfoldwhite"
	base_icon_state = "blindfoldwhite"
	inhand_icon_state = "blindfoldwhite"
	trick = TRUE


/obj/item/clothing/glasses/apoc/blindfold/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_EYES && !trick)
		user.become_blind("blindfold_[REF(src)]")

/obj/item/clothing/glasses/apoc/blindfold/dropped(mob/living/carbon/human/user)
	..()
	user.cure_blind("blindfold_[REF(src)]")


/obj/item/clothing/glasses/apoc/blindfold/AltClick(mob/user)
	if(!ishuman(user))
		return
	adjust_blindfold()


/obj/item/clothing/glasses/apoc/blindfold/proc/adjust_blindfold(mob/living/carbon/user)
	var/oldname

	switch(adjusted_state)
		if("both")
			adjusted_state = "left"
			name = "eyepatch"
			desc = "A fabric eyepatch over your left eye."
			oldname = "blindfold"
		if("left")
			adjusted_state = "right"
			desc = "A fabric eyepatch over your right eye."
		if("right")
			adjusted_state = "head"
			name = "headband"
			desc = "A tied fabric headband."
			oldname = "eyepatch"
		if("head")
			adjusted_state = "both"
			desc = initial(desc)
			oldname = "headband"

	worn_icon_state = "[base_icon_state]_[adjusted_state]"

	to_chat(user, span_notice("You adjust the [oldname], wearing it as a [name]."))

	user.update_inv_glasses()
