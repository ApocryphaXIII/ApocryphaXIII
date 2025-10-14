// APOC EDIT START
// weed seeds
// weed
// weed packs
//	//

/obj/item/weedseed
	name = "seed"
	desc = "Green and smelly..."
	icon_state = "seed"
	icon = 'code/modules/wod13/items.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/weedseed/Initialize()
	. = ..()
	name = pick(list(
		"acapulco gold",
		"afghani #1",
		"ak-47",
		"amnesia haze",
		"big bud and the goo",
		"blue dream",
		"blueberry",
		"bruce banner #3",
		"bubba kush",
		"bubblegum",
		"cannatonic",
		"cheese",
		"chem dog",
		"chem ’04",
		"chem ’91",
		"chocolope",
		"critical mass",
		"critical+",
		"durban poison",
		"g-13",
		"girl scout cookies",
		"grand daddy purple",
		"hashplant",
		"headband",
		"hindu kush",
		"jack herer",
		"kali mist",
		"laughing buddha",
		"lavender",
		"matanuska thunder fuck",
		"maui wowie",
		"mexican sativa",
		"nevil’s haze",
		"northern lights #5",
		"og ghost train haze",
		"og kush",
		"original haze",
		"purple chemdawg",
		"purple haze",
		"sensi star",
		"skunk #1",
		"skunkberry",
		"sour diesel",
		"strawberry cough",
		"super lemon haze",
		"super silver haze",
		"thai stick",
		"white widow"))

/obj/item/food/vampire/weed
	name = "leaf"
	desc = "A pointy leaf commonly associated with getting absolutely blitzed."
	icon_state = "weed"
	icon = 'code/modules/wod13/items.dmi'
	ONFLOOR_ICON_HELPER('code/modules/wod13/onfloor.dmi')
	bite_consumption = 5
	tastes = list("skunk" = 4, "cabbage" = 2)
	foodtypes = VEGETABLES
	food_reagents = list(/datum/reagent/drug/cannabis = 40)
	eat_time = 10
	illegal = TRUE
	cost = 50
	var/strain_name = "og kush"

/obj/item/food/vampire/weed/examine(mob/user)
	. = ..()
	. += span_notice("[src] is a hybrid of [strain_name]")

/obj/item/food/vampire/weed/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(istype(attacking_item, /obj/item/baggie))
		var/obj/item/food/vampire/weed/doctor_bluntensteins_monster = new /obj/item/weedpack
		doctor_bluntensteins_monster.name = "[strain_name] [name]"
		doctor_bluntensteins_monster.strain_name = strain_name
		remove_item_from_storage(user)

		qdel(attacking_item)
		qdel(src)

		user.put_in_hands(doctor_bluntensteins_monster)
		to_chat(user, span_notice("You place the [name] into the baggie and seal it."))
		return TRUE
	return FALSE // APOC EDIT END

/obj/item/food/vampire/weed/Initialize()
	. = ..()
	name = pick(list(
		"atshitshi",
		"aunt mary",
		"baby bhang",
		"bammy",
		"blanket",
		"bo-bo",
		"bobo bush",
		"bomber",
		"boom",
		"broccoli",
		"cheeba",
		"chronic",
		"dagga",
		"ding",
		"dinkie dow",
		"dona juana",
		"dope",
		"flower top",
		"flower",
		"ganja",
		"gasper",
		"giggle smoke",
		"good giggles",
		"grass",
		"herb",
		"jolly green",
		"joy smoke",
		"juanita",
		"leaf",
		"mary jane",
		"pot",
		"reefer",
		"skunk",
		"weed"))
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

/obj/item/weedpack
	name = "green package"
	desc = "A small package of dried tightly packed kush. Perfect for stuffing into a bong or rolling up in paper."
	icon_state = "package_weed"
	icon = 'code/modules/wod13/items.dmi'
	w_class = WEIGHT_CLASS_SMALL
	ONFLOOR_ICON_HELPER('code/modules/wod13/onfloor.dmi')
	illegal = TRUE
	cost = 150
	//lace-able
	var/list/list_reagents = list(/datum/reagent/drug/cannabis = 30)

	var/pot_name = "leaf"
	var/strain_name = "og kush"


/obj/item/weedpack/examine(mob/user)
	. = ..()
	. += span_notice("[src] holds a [pot_name] that is a hybrid of [strain_name]")

/obj/item/weedpack/Initialize(mapload)
	. = ..()
	create_reagents(40, INJECTABLE)
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)


/obj/item/weedpack/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(istype(attacking_item, /obj/item/paper))
		var/obj/item/clothing/mask/cigarette/rollie/cannabis/doctor_bluntenstein = new /obj/item/clothing/mask/cigarette/rollie/cannabis
		doctor_bluntenstein.chem_volume = reagents.total_volume
		reagents.trans_to(doctor_bluntenstein, doctor_bluntenstein.chem_volume, transfered_by = user)

		doctor_bluntenstein.baggie_name = "[name]"

		remove_item_from_storage(user)

		qdel(attacking_item)
		qdel(src)

		user.put_in_hands(doctor_bluntenstein)
		to_chat(user, span_notice("You remove the [pot_name] from the package and quickly roll it up. You discard the baggie."))
		return TRUE
	return FALSE // APOC EDIT END

/obj/item/baggie
	name = "baggie"
	desc = "An empty bag."
	icon = 'icons/obj/storage.dmi'
	icon_state = "evidenceobj"
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/box/baggie
	name = "baggie box"
	desc = "A box claiming to contain baggies."

/obj/item/storage/box/baggie/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/baggie(src)
