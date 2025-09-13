/obj/item/storage/ashtray
	name = "ashtray"
	desc = "A small bowl for holding and disposing of smokestuffs."
	icon = 'modular_zapoc/modules/apoc_decor/icons/ashtray.dmi'
	icon_state = "ashtray"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound =  'sound/items/handling/drinkglass_pickup.ogg'
	color = "#303030"
	grid_width = 1 GRID_BOXES
	grid_height = 1 GRID_BOXES
	storage_max_columns = 4
	storage_max_rows = 4

/obj/item/storage/ashtray/proc/evaluate_ashtray_contents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)

	var/mutable_appearance/overlay_half = mutable_appearance(icon, "[initial(icon_state)]_overlay-half")
	var/mutable_appearance/overlay_full = mutable_appearance(icon, "[initial(icon_state)]_overlay-full")

	overlay_half.color = "#FFFFFF"
	overlay_full.color = "#FFFFFF"

	cut_overlay(list(overlay_half, overlay_full))

	if(contents.len >= STR.max_items/2)
		. += overlay_half
	else if(contents.len == STR.max_items)
		. -= overlay_half
		. += overlay_full

/obj/item/storage/ashtray/Entered()
	. = ..()
	evaluate_ashtray_contents()

/obj/item/storage/ashtray/Exited()
	. = ..()
	evaluate_ashtray_contents()

/obj/item/storage/ashtray/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 16
	STR.max_w_class = WEIGHT_CLASS_TINY
	STR.set_holdable(
		list(
			/obj/item/match,
			/obj/item/cigbutt,
			/obj/item/clothing/mask/cigarette,
			/obj/item/rollingpaper
			), list(/obj/item/clothing/mask/cigarette/pipe))

/obj/item/storage/ashtray/attack_self(mob/user)
	. = ..()

	var/ciggie_butts

	if(contents.len)
		user.visible_message(span_notice("[user] dumps [src] out onto the ground."), \
			span_notice("You dump [src] out onto the ground."))
		for(var/i in contents)
			if(istype(i, /obj/item/cigbutt))
				ciggie_butts += 1
				qdel(i)

		if(ciggie_butts > 8)
			new /obj/effect/decal/cleanable/ash/large(get_turf(user))
			ciggie_butts = 0
		else if (ciggie_butts)
			new /obj/effect/decal/cleanable/ash(get_turf(user))
			ciggie_butts = 0

		emptyStorage()
		playsound(user, 'modular_zapoc/master_files/sound/items/cig_snuff.ogg')
	else
		to_chat(user, span_warning("You dump [src] out onto the ground. Too bad it has nothing in it."))
