/obj/item/food/vampire/weed
	name = "leaf"
	desc = "A pointy leaf commonly associated with getting absolutely blitzed."
	icon_state = "weed"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	bite_consumption = 5
	tastes = list("skunk" = 4, "cabbage" = 2)
	foodtypes = VEGETABLES
	food_reagents = list(/datum/reagent/drug/cannabis = 40)
	eat_time = 10
	illegal = TRUE
	cost = 50
