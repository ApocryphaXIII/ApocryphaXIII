/obj/machinery/vending/hotdog
	name = "\improper Hotdoggo-Vend"
	desc = "An brand new hotdog vending machine."
	icon_state = "hotdog-vendor"
	icon_deny = "hotdog-vendor-deny"
	//panel_type = "panel17"
	vend_reply = "Have a scrumptious meal!"
	light_mask = "hotdog-vendor-light-mask"
	default_price = 1
	product_categories = list(
		list(
			"name" = "Food",
			"products" = list(
				/obj/item/food/hotdog = 8,
				/obj/item/food/butterdog = 2,
				/obj/item/food/nachos/movie = 8,
				/obj/item/food/cheesynachos/movie = 8,
			),
		),
		list(
			"name" = "Sauces",
			"products" = list(
				/obj/item/reagent_containers/food/condiment/pack/ketchup = 4,
				/obj/item/reagent_containers/food/condiment/pack/hotsauce = 4,
				/obj/item/reagent_containers/food/condiment/pack/bbqsauce = 4,
			),
		),
	)
	refill_canister = /obj/item/vending_refill/hotdog

/obj/item/vending_refill/hotdog
	machine_name = "\improper Hotdoggo-Vend"
	icon_state = "refill_snack"
