//SHOES

//SHOES

//SHOES

/obj/item/clothing/shoes/vampire
	name = "shoes"
	desc = "Comfortable-looking shoes."
	icon = 'code/modules/wod13/clothing.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	icon_state = "shoes"
	gender = PLURAL
	can_be_tied = FALSE
	ONFLOOR_ICON_HELPER('code/modules/wod13/onfloor.dmi')
	body_worn = TRUE
	cost = 5

/obj/item/clothing/shoes/vampire/brown
	icon_state = "shoes_brown"

/obj/item/clothing/shoes/vampire/white
	icon_state = "shoes_white"

/obj/item/clothing/shoes/vampire/jackboots
	name = "jackboots"
	desc = "Robust-looking boots."
	icon_state = "jackboots"
	pocket_storage_component_path = /datum/component/storage/concrete/vampboots

/datum/component/storage/concrete/vampboots
	max_w_class = WEIGHT_CLASS_NORMAL
	max_combined_w_class = 14
	max_items = 2

	silent = TRUE
	rustle_sound = FALSE

	attack_hand_interact = FALSE
	quickdraw = TRUE

	screen_max_columns = 2
	screen_max_rows = 2

/datum/component/storage/concrete/vampboots/Initialize() // APOC EDIT CHANGE - Added some vamp items
	. = ..()
	set_holdable(list(
		/obj/item/kitchen/knife, /obj/item/switchblade, /obj/item/pen,
		/obj/item/scalpel, /obj/item/reagent_containers/syringe, /obj/item/dnainjector,
		/obj/item/reagent_containers/hypospray/medipen, /obj/item/reagent_containers/dropper,
		/obj/item/implanter, /obj/item/screwdriver, /obj/item/weldingtool/mini,
		/obj/item/firing_pin, /obj/item/vamp/keys, /obj/item/melee/vampirearms/knife, /obj/item/vampire_stake, /obj/item/vtm_artifact/dagger_of_retribution,
		/obj/item/ammo_box/magazine, /obj/item/ammo_casing, /obj/item/reagent_containers/pill, /obj/item/reagent_containers/hypospray/medipen, /obj/item/stack/medical,
		/obj/item/clothing/gloves
		),
		list(/obj/item/screwdriver/power)
		)

/obj/item/clothing/shoes/vampire/jackboots/high
	name = "high boots"
	desc = "High boots. What else did you expect?"
	icon_state = "tall_boots"

/obj/item/clothing/shoes/vampire/jackboots/punk
	icon_state = "daboots"

/obj/item/clothing/shoes/vampire/jackboots/work
	icon_state = "jackboots_work"

/obj/item/clothing/shoes/vampire/sneakers
	name = "sneakers"
	desc = "Sport-looking sneakers."
	icon_state = "sneakers"

/obj/item/clothing/shoes/vampire/sneakers/red
	icon_state = "sneakers_red"

/obj/item/clothing/shoes/vampire/heels
	name = "heels"
	desc = "Rich-looking heels."
	icon_state = "heels"

/obj/item/clothing/shoes/vampire/heels/red
	icon_state = "heels_red"

/obj/item/clothing/shoes/vampire/businessscaly
	name = "scaly shoes"
	desc = "Shoes with scales."
	icon_state = "scales_shoes"

/obj/item/clothing/shoes/vampire/businessblack
	name = "black shoes"
	desc = "Classic black shoes."
	icon_state = "business_shoes"

/obj/item/clothing/shoes/vampire/businesstip
	name = "metal tip shoes"
	desc = "Shoes with a metal tip."
	icon_state = "metal_shoes"

/obj/item/clothing/shoes/vampire/blackfur
	name = "black fur boots"
	desc = "A furry pair of black and white boots"
	icon_state = "furboots_black"

/obj/item/clothing/shoes/vampire/brownfur
	name = "brown fur boots"
	desc = "A furry pair of brown boots"
	icon_state = "furboots_brown"

/obj/item/clothing/shoes/vampire/pumped
	name = "knee-high sneakers"
	desc = "these are the pumped up kicks you are looking for"
	icon_state = "pumped_up_kicks"

/obj/item/clothing/shoes/vampire/flats
	name = "black flats"
	desc = "A pair of women's flats."
	icon_state = "flatsblack"

/obj/item/clothing/shoes/vampire/flats/brown
	name = "brown flats"
	icon_state = "flatsbrown"

/obj/item/clothing/shoes/vampire/flats/white
	name = "white flats"
	icon_state = "flatswhite"

/obj/item/clothing/shoes/vampire/flats/red
	name = "red flats"
	icon_state = "flatsred"

/obj/item/clothing/shoes/vampire/flats/orange
	name = "orange flats"
	icon_state = "flatsorange"

/obj/item/clothing/shoes/vampire/flats/purple
	name = "purple flats"
	icon_state = "flatspurple"

/obj/item/clothing/shoes/vampire/flats/blue
	name = "blue flats"
	icon_state = "flatsblue"

/obj/item/clothing/shoes/vampire/sneakers_blue
	name = "blue sneakers"
	desc = "A pair of blue sneakers."
	icon_state = "sneakers_blue"
